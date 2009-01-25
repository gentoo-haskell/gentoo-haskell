{-
  Lambdaman, repomanish verification for gentoo-haskell

  Lennart Kolmodin 2009 <kolmodin@gentoo.org>
-}

module Main where

import Control.Monad ( forM, forM_, guard )
import Data.List ( isSuffixOf )
import System.Directory ( getCurrentDirectory, getDirectoryContents, doesFileExist )
import System.Environment ( getEnvironment )
import Data.Maybe ( catMaybes, listToMaybe, isNothing, isJust )
import qualified Data.Digest.Pure.SHA as D ( Digest, showDigest, sha1, sha256 )
import qualified Data.ByteString.Char8 as C
import qualified Data.ByteString.Lazy as L
import System.IO
import System.IO.Unsafe
import System.FilePath ( (</>), takeFileName )

type Manifest = [MDigest]
data MDigest = MDigest {
    mManifestKind :: ManifestKind,
    mFileName :: String,
    mFileSize :: Int,
    mRmd160 :: String,
    mSha1 :: String,
    mSha256 :: String
  } deriving (Eq, Show)

data ManifestKind = DIST | AUX | EBUILD deriving (Eq, Show)

data Repo 
      = Dir FilePath [Repo]
      | File FilePath Int D.Digest
      deriving (Eq, Show)

readManifest :: FilePath -> IO Manifest
readManifest m = return . catMaybes . map parseManifestLine . lines =<< readFile m

parseManifestLine :: String -> Maybe MDigest
parseManifestLine row = do
  [kindStr, fn, fs, "RMD160", rmd, "SHA1", sha1, "SHA256", sha256] <- return (words row)
  kind <- case kindStr of
            "AUX" -> return AUX
            "DIST" -> return DIST
            "EBUILD" -> return EBUILD
            _ -> fail "unknown type"
  return (MDigest kind fn (read fs) rmd sha1 sha256)

fileSpy :: FilePath -> IO Repo
fileSpy fn = do
  fs <- unsafeInterleaveIO $ withFile fn ReadMode hFileSize
  fc <- unsafeInterleaveIO $ L.readFile fn
  return (File fn (fromInteger fs) (D.sha1 fc))

dirSpy :: FilePath -> IO Repo
dirSpy dir = do
  files0 <- getDirectoryContents dir
  let files = filter (`notElem` [".",".."]) files0
      fullNames = map (dir</>) files
  content <- forM fullNames $ \fn -> unsafeInterleaveIO $ do
                isFile <- doesFileExist fn
                if isFile
                  then fileSpy fn
                  else dirSpy fn
  return (Dir dir content)

findManifests :: Repo -> [(FilePath, Repo)]
findManifests d@(Dir _ sub) = cwd ++ recurse
  where
  recurse = concat [ findManifests d' | d'@(Dir _ _) <- sub ]
  cwd = [ (fn,d) | f@(File fn _ _) <- sub, "/Manifest" `isSuffixOf` fn ]

verifyDir :: (Manifest, Repo) -> [String]
verifyDir (manifest,(Dir dn repos)) = missingDigests
  where
    lookupFile fn = listToMaybe [ f | f@(File fn' _ _) <- repos, takeFileName fn' == fn ]
    lookupMani fn = listToMaybe [ m | m <- manifest, mFileName m == takeFileName fn ]

    missingDigests =
      [ "Manifest entry missing for file " ++ fn
      | f@(File fn fs sha1) <- repos
      , ".ebuild" `isSuffixOf` fn
      , isNothing (lookupMani fn)
      ]
    -- XXX: add more checks

ignore_darcs :: Repo -> Repo
ignore_darcs (Dir fn sub) = Dir fn (catMaybes (map recursive sub))
  where
  recursive (Dir fn sub') | "_darcs" `isSuffixOf` fn = Nothing
                          | otherwise = Just $ Dir fn (map ignore_darcs sub')
  recursive x = Just x
ignore_darcs x = x

main :: IO ()
main = do
  pwd <- getCurrentDirectory
  repo <- dirSpy pwd
  let dirs = findManifests (ignore_darcs repo)
  manis <- forM dirs $ \(fp, repo) -> do
              mani <- readManifest fp
              return (mani, repo)
  mapM_ putStrLn (concatMap verifyDir manis)
  -- XXX: get a list of files in the overlay with 'darcs show files' and
  -- check which are in manifests but not added to the overlay
