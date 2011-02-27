{-# LANGUAGE ViewPatterns #-}
{-
  Lambdaman, repomanish verification for gentoo-haskell

  BSD3
  
  Lennart Kolmodin 2009-2011 <kolmodin@gentoo.org>
-}

module Main ( main ) where

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
import System.FilePath ( (</>), takeFileName, takeBaseName, makeRelative )
import System.Process ( readProcess )

import Debug.Trace

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

readGit :: IO [FilePath]
readGit = do
  files <- readProcess "git" ["ls-files"] ""
  return (lines files)

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
  cwd = [ (fn,d) | f@(File fn _ _) <- sub, takeFileName fn == "Manifest" ]

verifyManifests :: [FilePath] -> (Manifest, Repo) -> [String]
verifyManifests awares (manifest, topRepo@(Dir _ packageDir)) =
    concat [ missingDigests topRepo
           , maybe [] missingDigests filesDir
           , invalidEbuildDigests topRepo
           , maybe [] invalidEbuildDigests filesDir
           , unknownToGit
           ]
  where
    filesDir = listToMaybe [ d | d@(Dir (takeBaseName -> "files") sub) <- packageDir ]
    lookupFile fn = listToMaybe [ f | f@(File fn' _ _) <- packageDir, takeFileName fn' == fn ]
    lookupMani fn = listToMaybe [ m | m <- manifest, mFileName m == takeFileName fn ]
    inGit      fn = not . null $ [ () | dfn <- awares, dfn == fn ]

    missingDigests (Dir _ subs) = -- look for missing manifest entries
      [ "Manifest entry missing for file " ++ fn
      | f@(File fn fs digest) <- subs
      , takeBaseName fn /= "Manifest" -- manifests are never included in the manifest
      , isNothing (lookupMani fn)
      , not ("/ChangeLog" `isSuffixOf` fn)   -- ChangeLog is not part of the manifest
      , not ("/metadata.xml" `isSuffixOf` fn) -- neither is metadata.xml
      ]

    invalidEbuildDigests (Dir _ subs) = -- look for incorrect filesize or manifest inconsistencies
      [ "Invalid Manifest entry for file " ++ fn
      | f@(File fn fs sha1) <- subs
      , Just (MDigest { mFileSize = size, mSha1 = digest }) <- return (lookupMani fn)
      , fs /= size || digest /= show sha1
      ]

    unknownToGit = -- look for ebuilds in manifest unknown to git
      [ "Ebuild in manifest but unknown to git: " ++ fullName
      | m <- manifest
      , Just (Dir dn _) <- return $ -- find the right subdir for the kind of file were examining
          case mManifestKind m of
            AUX -> filesDir
            DIST -> Nothing -- we don't check distfiles, our SHA is too slow for big files
            EBUILD -> return topRepo
      , let fullName = makeRelative "." (dn </> mFileName m)
      , not (inGit fullName)
      ]

ignore_git :: Repo -> Repo
ignore_git (Dir fn sub) = Dir fn (catMaybes (map recursive sub))
  where
  recursive (Dir fn sub') | fn == ".git" = Nothing
                          | otherwise = Just $ Dir fn (map ignore_git sub')
  recursive x = Just x
ignore_git x = x

main :: IO ()
main = do
  -- pwd <- getCurrentDirectory
  putStrLn "lambdaman scours the neighborhood..."
  repo <- dirSpy "."
  let dirs = findManifests (ignore_git repo)
  manis <- forM dirs $ \(fp, repo) -> do
              mani <- readManifest fp
              return (mani, repo)
  gitAwares <- readGit
  putStrLn $ "git knows about " ++ show (length gitAwares) ++ " files"
  let digestErrors = concatMap (verifyManifests gitAwares) manis
  case digestErrors of
    [] -> putStrLn "No manifest errors found"
    _ -> do putStrLn "Naughty naughty!"
            mapM_ putStrLn digestErrors
            putStrLn $ show (length digestErrors) ++ " error(s) found."
  putStrLn "lambdaman goes back to sleep...\n"
