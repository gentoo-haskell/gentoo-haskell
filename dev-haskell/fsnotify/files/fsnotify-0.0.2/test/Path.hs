--
-- Copyright (c) 2012 Mark Dittmer - http://www.markdittmer.org
-- Developed for a Google Summer of Code project - http://gsoc2012.markdittmer.org
--
{-# LANGUAGE CPP #-}

module Path (spec) where

import Prelude hiding (FilePath, writeFile)

import Control.Applicative ((<*>))
import Filesystem (writeFile)
import Filesystem.Path.CurrentOS (FilePath)
import Filesystem.Path ((</>), empty)
import System.FilePath.Glob (compile, match)
import System.FSNotify.Path (canonicalizeDirPath, canonicalizePath, findDirs, findFiles, fp)
import Test.Hspec (describe, it, Spec, shouldBe)
import Util
import qualified Data.ByteString as BS
type Assertion = IO ()

-- Boolean XOR
(.^.) :: Bool -> Bool -> Bool
(.^.) True  True  = False
(.^.) True  False = True
(.^.) False True  = True
(.^.) False False = False

hasTrailingSlash :: FilePath -> (FilePath -> IO FilePath) -> Assertion
hasTrailingSlash path canonicalizeFn = do
  let expectedTail = last $ fp (fp "dir" </> empty) -- Get OS/filesystem's idea of a separator
  actualPath <- canonicalizeFn path
  let actualTail = last (fp actualPath) :: Char
  actualTail `shouldBe` expectedTail

relPath      :: FilePath
relPathSlash :: FilePath
absPath      :: FilePath
absPathSlash :: FilePath

relPath      = fp "."
#ifdef OS_Linux
absPath      = fp "/home"
absPathSlash = fp "/home/"
relPathSlash = fp "./" </> empty
#else
#  ifdef OS_Win32
absPath      = fp "C:" </> fp "Windows"
absPathSlash = fp "C:" </> fp "Windows" </> empty
relPathSlash = fp ".\\" </> empty
#  else
#    ifdef OS_Mac
absPath      = fp "/Users"
absPathSlash = fp "/Users/"
relPathSlash = fp "./"
#    else
-- Assume UNIX-like for anything non-Linux/Windows/Mac
absPath      = fp "/home"
absPathSlash = fp "/home/"
relPathSlash = fp "./" </> empty
#    endif
#  endif
#endif


spec :: Spec
spec = do
  describe "canonicalizeDirPath" $ do
    it "Absolute path keeps trailing slash" $ do
      hasTrailingSlash absPathSlash canonicalizeDirPath
    it "Absolute path gains trailing slash" $ do
      hasTrailingSlash absPath canonicalizeDirPath
    it "Relative path keeps trailing slash" $ do
      hasTrailingSlash relPathSlash canonicalizeDirPath
    it "Relative path gains trailing slash" $ do
      hasTrailingSlash relPath canonicalizeDirPath
  describe "canonicalizePath" $ do
    it "Absolute path keeps trailing slash" $ do
      hasTrailingSlash absPathSlash canonicalizePath
    it "Relative path keeps trailing slash" $ do
      hasTrailingSlash relPathSlash canonicalizePath
  describe "findFiles" $ do
    it "Non-recursive" $ do
      withTempDir $ \tmpDir -> do
        fileName <- testFileName "txt"
        writeFile (tmpDir </> fileName) BS.empty
        files <- findFiles False tmpDir
        1 `shouldBe` length files
        let (resultFP:_) = files
            pattern = "**/*" ++ fp fileName
            result = fp resultFP
        if match (compile pattern) result then
          True `shouldBe` True
          else
          result `shouldBe` pattern
    it "Recursive" $ do
      withTempDir $ \tmpDir -> do
        withNestedTempDir tmpDir $ \tmpPath -> do
          fileName <- testFileName "txt"
          writeFile (tmpPath </> fileName) BS.empty
          files <- findFiles True tmpDir
          1 `shouldBe` length files
          let (resultFP:_) = files
              pattern = "**/*" ++ fp fileName
              result = fp resultFP
          if match (compile pattern) result then
            True `shouldBe` True
            else
            result `shouldBe` pattern
  describe "findDirs" $ do
    it "Non-recursive" $
      withTempDir $ \tmpDir -> do
        withNestedTempDir tmpDir $ \dirName -> do
          dirs <- findDirs False tmpDir
          1 `shouldBe` length dirs
          let (resultFP:_) = dirs
              pattern = "**/*" ++ fp dirName
              result = fp resultFP
          if match (compile pattern) result then
            True `shouldBe` True
            else
            result `shouldBe` pattern
    it "Recursive" $
      withTempDir $ \tmpDir -> do
        withNestedTempDir tmpDir $ \dirName1 -> do
          withNestedTempDir tmpDir $ \dirName2 -> do
            dirs <- findDirs False tmpDir
            2 `shouldBe` length dirs
            let pats = ["**/*" ++ fp dirName1, "**/*" ++ fp dirName2]
                patFns = map (match . compile) pats
                dirStrings = map fp dirs
                (r1:r2:r3:r4:_) = patFns <*> dirStrings
            -- The two patterns should succeed once and fail once on
            -- opposite tests.
            if (r1 .^. r2) && (r3 .^. r4) && (r1 .^. r3) && (r2 .^. r4) then
              True `shouldBe` True
              else
              dirStrings `shouldBe` pats
            return ()
