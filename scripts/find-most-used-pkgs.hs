-- Scan the haskell repo and find the most-referenced packages
--
-- The following external commands are required:
--     qdepends (app-portage/portage-utils)
--     qatom (app-portage/portage-utils)
--     pquery (sys-apps/pkgcore)

{-# Language ApplicativeDo #-}
{-# Language MultiWayIf #-}
{-# Language OverloadedStrings #-}
{-# Language PackageImports #-}
{-# OPTIONS_GHC -Wall -with-rtsopts=N #-}

import           "parser-combinators" Control.Applicative.Combinators
import           Control.Monad
import           "mtl" Control.Monad.State.Strict
import           Data.Char
import           "unordered-containers" Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as M
import qualified Data.IntMap.Strict as IM
import qualified Data.List as L
import           Data.Maybe
import           Data.Set (Set)
import qualified Data.Set as S
import           Data.Text (Text)
import qualified Data.Text as T
import           Data.Void (Void)
import           "megaparsec" Text.Megaparsec
import           "megaparsec" Text.Megaparsec.Char
import           System.Exit
import           System.IO
import           "process-extras" System.Process.Text

-- Name of the haskell repo
haskellRepo :: String
haskellRepo = "haskell"

-- How many listings to display at the end (Nothing signifies no limit)
totalListings :: Maybe Int
totalListings = Nothing

data Atom = Atom 
    { category :: Text
    , package :: Text
    , version :: Text
    , revision :: Maybe Text
    , slot :: Text
    }
    deriving (Show, Eq, Ord)

type Parser = Parsec Void Text
type CatPkg = (Text,Text)
type CountMap = HashMap CatPkg Int

-- Carries a set of packages that should be excluded from the final listing
type WithExcludeSet = StateT (Set CatPkg)

main :: IO ()
main = do
    pkgs <- runWithNotify "Gathering list of ebuilds" haskellPkgs
    atoms <- runWithNotify "Converting list to atoms" $ traverse haskellAtom pkgs
    let cMap0 = initCountMap atoms
    cMap <- evalStateT (foldM addToMap cMap0 atoms) S.empty
    iMap <- runWithNotify "Gathering results" $ pure $
        IM.fromListWith (<>) $ map (\(cp,i) -> (i, S.singleton cp)) (M.toList cMap)
    let iMap' = IM.delete 0 iMap -- Remove listings with 0 references
        listings :: [(Text, Text, Int)] =
            -- Unfold the data structure into a list of triples
            [ (c,p,i) | (i,s) <- IM.toDescList iMap', (c,p) <- S.toList s ]
        -- Limit the number of listings to display by totalListings
        limit = maybe id take totalListings
        -- How to display a single listing as a line on the terminal output
        showListing (c,p,i) = T.unpack c ++ "/" ++ T.unpack p ++ ": " ++ show i
    mapM_ (putStrLn . showListing) (limit listings)
  where
    addToMap :: CountMap -> Atom -> WithExcludeSet IO CountMap
    addToMap cMap atom = do
        mdeps <- runWithNotifyMaybe
            ("Gathering dependency atoms for " ++ showAtom atom)
            "MASKED!"
            (atomDepends atom)
        case mdeps of
            Just deps -> do
                -- Filter out excluded dependencies
                deps' <- filterM (filterDep cMap) $
                    -- Make sure all category/package pairs are unique
                    L.nubBy (\a1 a2 -> toCatPkg a1 == toCatPkg a2) deps
                pure $ foldr
                    (\cp m -> M.insertWith (+) cp 1 m)
                    cMap
                    (map toCatPkg deps')
            Nothing -> pure cMap

    filterDep :: CountMap -> Atom -> WithExcludeSet IO Bool
    filterDep cMap a = do
        badSet <- get
        let cp = toCatPkg a
        if | M.member cp cMap -> pure True
           | S.member cp badSet -> pure False
           | otherwise -> do
                b <- isJust <$> atomDepends a
                if b then pure True else do
                    -- Add the CatPkg to the exclude set
                    modify (S.insert cp)
                    pure False

atomParser :: Parser Atom
atomParser = do
    c <- takeSkipSpace
    p <- takeSkipSpace
    v <- takeSkipSpace
    r <- optional takeSome
    _ <- skipSpace
    s <- option "0" takeSome
    _ <- skipSpace
    _ <- takeMany -- pfx
    _ <- skipSpace
    _ <- takeMany -- sfx
    _ <- eol
    _ <- eof
    pure $ Atom c p v r s
  where
    takeMany = takeWhileP (Just "possible prefix/suffix") (not . isSpace)
    takeSome = takeWhile1P (Just "non-whitespace string") (not . isSpace)
    skipSpace = takeP (Just "space delimiter") 1
    takeSkipSpace = takeSome <* skipSpace

qdependsParser :: Parser [Text]
qdependsParser = do
    _ <- takeWhile1P (Just "qdepends header") (\c -> not (isSpace c) && c /= ':')
    _ <- ":"
    ts <- go
    _ <- eof
    pure ts
  where
    go :: Parser [Text]
    go = do
        choice
            [ [] <$ eol
            , do
                _ <- takeWhile1P (Just "space delimiter") (== ' ')
                ts <- takeWhile1P (Just "dependency string") (not . isSpace)
                rest <- go
                pure $ ts : rest
            ]

haskellPkgs :: IO [Text]
haskellPkgs =
    T.lines <$> runCmd "/usr/bin/pquery" ["--repo", haskellRepo, "--all"]

haskellAtom :: Text -> IO Atom
haskellAtom pkg =
    runCmd "/usr/bin/qatom" [T.unpack pkg]
        >>= parseIO atomParser atomSource
  where
    atomSource = "qatom output (" ++ T.unpack pkg ++ ")"

atomDepends :: MonadIO m => Atom -> m (Maybe [Atom])
atomDepends a = liftIO $ do
    mt <- runQdepends ["-drpbIt", showAtom a]
    forM mt $ \t -> parseIO qdependsParser qdepSource t
        >>= traverse haskellAtom
  where
    qdepSource = "qdepends output (" ++ showAtom a ++ ")"

-- Creates a valid ::haskell atom from an Atom
showAtom :: Atom -> String
showAtom (Atom c p v mr s)
    =  T.unpack c
    ++ "/" ++ T.unpack p
    ++ "-" ++ T.unpack v
    ++ maybe "" (\r -> "-" ++ T.unpack r) mr
    ++ ":" ++ T.unpack s
    ++ "::" ++ haskellRepo

toCatPkg :: Atom -> (Text, Text)
toCatPkg (Atom c p _ _ _) = (c,p)

initCountMap :: [Atom] -> CountMap
initCountMap as = M.fromList $ zip (map toCatPkg as) (repeat 0)


runCmd
    :: FilePath
    -> [String]
    -> IO Text
runCmd cmd args = do
    (ec, o, e) <- readProcessWithExitCode cmd args ""
    case ec of
        ExitSuccess -> pure o
        ExitFailure i -> error (runCmdErr cmd args i o e)

-- Special case of runCmd for qdepends
runQdepends
    :: [String]
    -> IO (Maybe Text)
runQdepends args = do
    let cmd = "/usr/bin/qdepends"
    (ec, o, e) <- readProcessWithExitCode cmd args ""
    case ec of
        ExitSuccess -> pure (Just o)
        ExitFailure i -> do
            if "qdepends: no matches found" `T.isPrefixOf` e
                then pure Nothing -- Ignore results that qdepend can't find
                else error (runCmdErr cmd args i o e)

-- Shared between runCmd and runQdepends
runCmdErr :: FilePath -> [String] -> Int -> Text -> Text -> String
runCmdErr cmd args i o e = T.unpack
    $  "Unexpected exit code " <> showText i <> " for: "
    <> showText cmd <> " " <> showText args <> " stdout: "
    <> showText o <> " stderr: " <> showText e

-- Display a notification and "done!" when the action finishes
runWithNotify :: MonadIO m => String -> IO a -> m a
runWithNotify s io = liftIO $ do
    hPutStr stderr $ s ++ "... "
    r <- io
    hPutStrLn stderr "done!"
    pure r

-- Same as runWithNotify but takes an extra string that will be emitted in
-- the event of a Nothing
runWithNotifyMaybe :: MonadIO m
    => String -> String -> IO (Maybe a) -> m (Maybe a)
runWithNotifyMaybe s err io = liftIO $ do
    hPutStr stderr $ s ++ "... "
    r <- io
    hPutStrLn stderr $ case r of
        Just _ -> "done!"
        Nothing -> err
    pure r

showText :: Show a => a -> Text
showText = T.pack . show

-- Run a megaparsec parser, but throw an error if it fails
parseIO :: Parser a -> String -> Text -> IO a
parseIO p s t = either err pure $ parse p s t
  where
   err e = error $ unlines
        [ "parser input: " ++ show t
        , errorBundlePretty e
        ]
