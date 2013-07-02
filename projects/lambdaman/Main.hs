{-# LANGUAGE ViewPatterns #-}
{-
  Lambdaman, repomanish verification for gentoo-haskell

  BSD3
  
  Lennart Kolmodin 2009-2011 <kolmodin@gentoo.org>
-}

module Main ( main ) where

import Control.Monad ( forM, filterM )
import Data.List ( (\\) )
import System.Directory ( getDirectoryContents, doesFileExist )
import System.Posix.Files (getFileStatus, isDirectory)

import Data.Maybe ( catMaybes, listToMaybe, isNothing )
import qualified Data.Digest.Pure.SHA as D ( sha1, showDigest )
import qualified Data.ByteString as S
import qualified Data.ByteString.Char8 as S8
import qualified Data.ByteString.Lazy as L
import System.IO
import System.IO.Unsafe
import System.FilePath ( (</>), takeFileName, takeBaseName, makeRelative, normalise, splitPath, joinPath )
import System.Process ( readProcess )

-- import Debug.Trace

type Manifest = [MDigest]
data MDigest = MDigest {
    mManifestKind :: ManifestKind,
    mFileName :: String,
    mFileSize :: Int,
    mRmd160 :: String,
    mSha1 :: String,
    mSha256 :: String
  } deriving (Eq, Show)

data ManifestKind
       = DIST
       | AUX
       | EBUILD
       | MISC
       deriving (Eq, Show)

data Repo
      = Dir FilePath [Repo]
      | File FilePath Int String
      deriving (Eq, Show)

flatten :: Repo -> [Repo]
flatten f@(File _ _ _) = [f]
flatten d@(Dir _ entries) = d : concatMap flatten entries

readManifest :: FilePath -> IO Manifest
readManifest m = return . catMaybes . map parseManifestLine . lines =<< S8.unpack `fmap` S8.readFile m

parseManifestLine :: String -> Maybe MDigest
parseManifestLine row = do
  [kindStr, fn, fs, "RMD160", rmd, "SHA1", sha1, "SHA256", sha256] <- return (words row)
  kind <- case kindStr of
            "AUX"    -> return AUX
            "DIST"   -> return DIST
            "EBUILD" -> return EBUILD
            "MISC"   -> return MISC
            _ -> fail "unknown type"
  return (MDigest kind fn (read fs) rmd sha1 sha256)

readGit :: IO [FilePath]
readGit = do
  files <- readProcess "git" ["ls-files"] ""
  return (lines files)

fileSpy :: FilePath -> IO Repo
fileSpy fn = do
  fs <- unsafeInterleaveIO $ withFile fn ReadMode hFileSize
  fc <- unsafeInterleaveIO $ {- read whole file -} L.fromStrict `fmap` S.readFile fn
  return (File (normalise fn) (fromInteger fs) (D.showDigest (D.sha1 fc)))

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
findManifests d@(Dir _ files) = cwd ++ recurse
  where
  recurse = concat [ findManifests d' | d'@(Dir _ _) <- files ]
  cwd = [ (fn,d) | File fn _ _ <- files, takeFileName fn == "Manifest" ]

verifyManifests :: [FilePath] -> (Manifest, Repo) -> [String]
verifyManifests awares (manifest, topRepo@(Dir _ packageDir)) =
    concat [ missingDigests topRepo
           , maybe [] missingDigests filesDir
           , invalidEbuildDigests topRepo
           , maybe [] invalidEbuildDigests filesDir
           , unknownToGit
           , unknownToFS
           ]
  where
    filesDir = listToMaybe [ d | d@(Dir (takeBaseName -> "files") _) <- packageDir ]
    lookupFile dir fn = listToMaybe [ f | f@(File fn' _ _) <- concatMap flatten dir, drop_cat_pkg fn' == fn || drop_cat_pkg_files fn' == fn ]
    lookupMani     fn = listToMaybe [ m | m <- manifest, mFileName m == takeFileName fn ]
    inGit          fn = not . null $ [ () | dfn <- awares, dfn == fn ]

    drop_cat_pkg       = joinPath . drop 2 .splitPath
    drop_cat_pkg_files = joinPath . drop 3 .splitPath

    missingDigests (Dir _ files) = -- look for missing manifest entries
      [ "Manifest entry missing for file " ++ fn
      | File fn _fs _digest <- files
      , takeBaseName fn /= "Manifest" -- manifests are never included in the manifest
      , isNothing (lookupMani fn)
      ]

    invalidEbuildDigests (Dir _ files) = -- look for incorrect filesize or manifest inconsistencies
      [ "Invalid Manifest entry for file " ++ fn
      | File fn fs sha1 <- files
      , Just (MDigest { mFileSize = size, mSha1 = digest }) <- return (lookupMani fn)
      , fs /= size || digest /= sha1
      ]

    unknownToFS = -- look for ebuilds/files in manifest unknown to the file system
      [ "File in manifest but missing in the file system: " ++ fullName
      | m <- manifest
      , Just (Dir dn files) <- return $ -- find the right subdir for the kind of file were examining
          case mManifestKind m of
            AUX -> filesDir
            DIST -> Nothing -- we don't check distfiles, our SHA is too slow for big files
            EBUILD -> return topRepo
            MISC -> return topRepo
      , let fullName = makeRelative "." (dn </> mFileName m)
      , isNothing (lookupFile files (mFileName m))
      ]

    unknownToGit = -- look for ebuilds in manifest unknown to git
      [ "Ebuild in manifest but unknown to git: " ++ fullName
      | m <- manifest
      , Just (Dir dn _) <- return $ -- find the right subdir for the kind of file were examining
          case mManifestKind m of
            AUX -> filesDir
            DIST -> Nothing -- we don't check distfiles, our SHA is too slow for big files
            EBUILD -> return topRepo
            MISC -> return topRepo
      , let fullName = makeRelative "." (dn </> mFileName m)
      , not (inGit fullName)
      ]

-- returns (added cats, removed cats)
cats_status :: FilePath -> IO ([FilePath], [FilePath])
cats_status cats_file =
    do -- check for 'categories' consistency
       let banlist = [ "."
                     , ".."
                     , ".git"
                     , ".hackport"
                     , "eclass"
                     , "profiles"
                     , "projects"
                     , "metadata"
                     ]

       known_cats <- readFile cats_file >>= return . lines
       found_cats <- do entries <- getDirectoryContents "."
                        dirs    <- filterM ((isDirectory `fmap`) . getFileStatus) entries
                        return $ filter (`notElem` banlist) dirs

       return (known_cats \\ found_cats, found_cats \\ known_cats)

ignore_git :: Repo -> Repo
ignore_git (Dir fn' files) = Dir fn (catMaybes (map recursive files))
  where
  fn = normalise fn'
  recursive (Dir fn files') | fn == ".git" = Nothing
                            | otherwise = Just $ Dir fn (map ignore_git files')
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
{-
  -- disabled as we use tiny manifests now
  case digestErrors of
    [] -> putStrLn "No manifest errors found"
    _ -> do putStrLn "Naughty naughty!"
            mapM_ putStrLn digestErrors
            putStrLn $ show (length digestErrors) ++ " error(s) found."
-}
  (gone_cats, new_cats) <- cats_status ("profiles" </> "categories")

  mapM_ (putStrLn . ("GONE CATEGORY: " ++)) gone_cats
  mapM_ (putStrLn . ("NEW  CATEGORY: " ++)) new_cats

  putStrLn "lambdaman goes back to sleep...\n"
