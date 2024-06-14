-- Usage: runhaskell scan-ghc-library-versions.hs [OPTION...] <GHC version>
--
-- This utility is to be used in a GHC git repository:
-- git clone https://gitlab.haskell.org/ghc/ghc.git/
--
-- WARNING: This utility will wipe all changes from the local git repo!
-- Only use this in a throwaway git repo!

{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE PackageImports #-}

module Main (main) where

import Control.Monad
import qualified Data.ByteString as BS
import Data.Foldable (toList)
import Data.Functor.Const (Const(..))
import Data.Functor.Identity (Identity(..))
import Data.List (intercalate)
import Data.Maybe (catMaybes)
import "Cabal-syntax" Distribution.InstalledPackageInfo
    (InstalledPackageInfo, parseInstalledPackageInfo)
import "Cabal-syntax" Distribution.Package
    (packageName, packageVersion, unPackageName)
import "Cabal-syntax" Distribution.Types.Version
    (versionNumbers)
import Distribution.Simple.Utils (warn)
import Distribution.Verbosity
import System.Console.GetOpt
import System.Directory
import System.Environment (getProgName, getArgs)
import System.FilePath
import System.Exit (ExitCode(..), exitSuccess, die)
import System.IO (stderr, hPutStr, hPutStrLn, hGetContents)
import System.Process
import qualified Text.PrettyPrint as PP
import Text.Read (readMaybe)

type Version = [Int]

data CabalFileType
    = CabalFile -- normal .cabal file
    | CabalIn -- .cabal.in file

data Library f = Lib
    String -- name
    FilePath -- directory
    (f (CabalFileType, FilePath)) -- cabal file; not initialized at first

type Lib = Library (Const ()) -- No cabal file located yet
type LibLocated = Library Identity

libraries :: [Lib]
libraries =
    [ lib "Cabal-syntax" ("libraries" </> "Cabal" </> "Cabal-syntax")
    , lib "Cabal" ("libraries" </> "Cabal" </> "Cabal")
    , stdlib "array"
    , stdlib "base"
    , stdlib "binary"
    , stdlib "bytestring"
    , lib "containers" ("libraries" </> "containers" </> "containers")
    , stdlib "deepseq"
    , stdlib "directory"
    , stdlib "exceptions"
    , stdlib "filepath"
    , stdlib "ghc-bignum"
    , stdlib "ghc-boot"
    , stdlib "ghc-boot-th"
    , stdlib "ghc-compact"
    , stdlib "ghc-heap"
    , stdlib "ghc-prim"
    , stdlib "ghci"
    , stdlib "haskeline"
    , stdlib "hpc"
    , stdlib "integer-gmp"
    , stdlib "mtl"
    , stdlib "parsec"
    , stdlib "pretty"
    , stdlib "process"
    , stdlib "semaphore-compat"
    , stdlib "stm"
    , stdlib "template-haskell"
    , stdlib "terminfo"
    , stdlib "text"
    , stdlib "time"
    , stdlib "transformers"
    , stdlib "unix"
    , stdlib "xhtml"
    ]

main :: IO ()
main = do
    (v, isV, isF) <- checkArgs
    let branch = "ghc-" ++ showVersion v ++ "-release"
        verb = if isV then normal else silent

    gitCmd isV ["checkout", "--force", branch]
    gitCmd isV ["submodule", "foreach", "--recursive", "git", "reset", "--hard"]
    gitCmd isV ["submodule", "update", "--init", "--recursive"]
    gitCmd isV ["clean", "-d", "-f", "-f"]

    mLibDocs <- forM libraries $ locateLib >=> \case
        Left w -> do
            warn verb w
            pure Nothing
        Right (Lib name _dir (Identity (cabalType, cabalPath))) -> do
            bs <- BS.readFile cabalPath
            case (cabalType, parseInstalledPackageInfo bs) of
                (CabalIn, Left _) -> pure $
                    -- .cabal.in files should have a fallback if they cannot be parsed
                    printLib isF name (Left "@ProjectVersionMunged@")
                (CabalIn, Right (_, ipi)) -> pure $ printIPI isF ipi
                (CabalFile, Left errs) -> die $ unwords
                    ["Errors when parsing", cabalPath, ":", show (toList errs)]
                (CabalFile, Right (_, ipi)) -> pure $ printIPI isF ipi

    putStrLn $ PP.render $ printLibs isF (catMaybes mLibDocs)
  where
    printLibs :: HaskellFormat -> [PP.Doc] -> PP.Doc
    printLibs True (d:ds) = PP.nest 2 $ PP.vcat $
        (PP.lbrack PP.<+> PP.text "p" PP.<+> d)
        : map (\d' -> PP.comma PP.<+> PP.text "p" PP.<+> d') ds
        ++ [PP.rbrack]
    printLibs True [] = PP.lbrack <> PP.rbrack
    printLibs False ds = PP.vcat ds

    printIPI :: HaskellFormat -> InstalledPackageInfo -> Maybe PP.Doc
    printIPI isF ipi =
        printLib isF
            (unPackageName (packageName ipi))
            (Right (versionNumbers (packageVersion ipi)))

    printLib
        :: HaskellFormat
        -> String
        -> Either String Version
        -> Maybe PP.Doc
    printLib isF n e = case (isF, e) of
        (True, Left _) -> Nothing
        (True, Right v) -> Just $ PP.text $ unwords [show n, show v]
        (False, ev) -> Just $
            let vDoc = PP.text $ either id showVersion ev
            in PP.fsep $ PP.punctuate PP.colon
                [ PP.text n, vDoc ]

locateLib :: Lib -> IO (Either String LibLocated)
locateLib (Lib n d _) = do
    let mkLib = Right . Lib n d . Identity
        cn = d </> n <.> "cabal"
        cd = d </> n <.> "cabal.in"
    cnExists <- doesFileExist cn
    cdExists <- doesFileExist cd
    pure $ case (cnExists, cdExists) of
        (True, _) -> mkLib (CabalFile, cn)
        (_, True) -> mkLib (CabalIn, cd)
        _ -> Left $ unwords
            [ "Cannot find", show cn, "or", show cd ]

-- Standard location for a library
stdlib :: String -> Lib
stdlib n = lib n ("libraries" </> n)

-- Smart constructor for an uninitialized Library
lib :: String -> FilePath -> Lib
lib n p = Lib n p (Const ())

-- Run a git command. stdout is redirected to stderr when verbose or
-- /dev/null otherwise. Errors are fatal.
gitCmd :: Verbose -> [String] -> IO ()
gitCmd isV args = findExecutable "git" >>= \case
    Nothing -> die "Cannot find git executable (install dev-vcs/git?)"
    Just exe -> do

        let cp = (proc exe args)
                { std_out = CreatePipe
                , std_err = CreatePipe }

        withCreateProcess cp $ \_ mHOut mHErr ph -> case (mHOut, mHErr) of
            (Just hOut, Just hErr) ->
                waitForProcess ph >>= \case
                    ExitSuccess
                        | isV -> dumpHandles [hOut, hErr] stderr
                        | otherwise -> pure ()
                    ExitFailure i -> do
                        dumpHandles [hOut, hErr] stderr
                        die $ unwords
                            [ "Command failed with exit code", show i ++ ":"
                            , unwords (show <$> exe : args) ]
            _ -> undefined
  where
    dumpHandles hs hOut = mapM_ (hPutStr hOut <=< hGetContents) hs

type Verbose = Bool
type HaskellFormat = Bool

data Mode
    = HelpMode
    | NormalMode Verbose HaskellFormat
    deriving (Show, Eq, Ord)

instance Semigroup Mode where
    HelpMode <> _ = HelpMode
    _ <> HelpMode = HelpMode
    NormalMode v1 f1 <> NormalMode v2 f2
        = NormalMode (v1 || v2) (f1 || f2)

instance Monoid Mode where
    mempty = NormalMode False False

-- Parses the version number and any mode info from the command line
checkArgs :: IO (Version, Verbose, HaskellFormat)
checkArgs = do
    progName <- getProgName
    argv <- getArgs
    let err str = showHelp progName *> die str

    case getOpt Permute options argv of
        (_,_,es@(_:_)) -> err (concat es)

        (ms,as,_) -> case (mconcat ms, as) of
            (HelpMode, _) -> showHelp progName *> exitSuccess
            (_, []) -> err "GHC version argument required"
            (_,(_:as'@(_:_))) -> err
                ("Extra command-line arguments given: " ++ show as')
            (NormalMode isV isF, [vStr]) -> case parseVersion vStr of
                Just v -> pure (v, isV, isF)
                Nothing -> err
                    ("Could not parse as a version [Int]: " ++ show vStr)
  where
    showHelp progName = hPutStrLn stderr (usageInfo (header progName) options)

    header progName = unlines $ unwords <$>
        [ ["Usage: runhaskell", progName, "[OPTION...]", "<GHC version>"]
        , []
        , ["This utility is to be used in a GHC git repository:"]
        , ["git clone https://gitlab.haskell.org/ghc/ghc.git/"]
        , []
        , ["WARNING: This utility will wipe all changes from the local git repo!"]
        , ["Only use this in a throwaway git repo!"]
        ]

    options :: [OptDescr Mode]
    options =
        [ Option ['h'] ["help"] (NoArg HelpMode) "Show this help text"
        , Option ['v'] ["verbose"] (NoArg (NormalMode True False))
            "Show debug output"
        , Option ['f'] ["hackport-format"] (NoArg (NormalMode False True))
            "Format output for use in GHCCore.hs (hackport)"
        ]

parseVersion :: String -> Maybe Version
parseVersion s = case span (/= '.') s of
    (iStr, (_:rest)) ->
        (:) <$> readMaybe iStr <*> parseVersion rest
    (end, []) -> (:[]) <$> readMaybe end

showVersion :: Version -> String
showVersion = intercalate "." . fmap show
