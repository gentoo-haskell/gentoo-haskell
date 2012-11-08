--
-- Copyright (c) 2012 Mark Dittmer - http://www.markdittmer.org
-- Developed for a Google Summer of Code project - http://gsoc2012.markdittmer.org
--

module FSNotify (spec) where

import Prelude hiding (appendFile, FilePath, writeFile)

import Control.Concurrent.Chan (newChan, writeChan)
import Data.ByteString (empty)
import Data.Text (pack)
import Data.Time.Clock.POSIX (posixSecondsToUTCTime)
import Filesystem (removeFile, rename, writeFile, writeTextFile)
import Filesystem.Path.CurrentOS ((</>), FilePath)
import System.FilePath.Glob (compile, match, Pattern)
import System.FSNotify.Path (fp)
import System.FSNotify.Types
import Test.Hspec (describe, it, Spec)
import Util
type Assertion = IO ()

spec :: Spec
spec = do
  describe "watchDir" $ do
    it "Create file" $ testFileName "txt" >>= createFileSpec ActionEnv
    it "Modify file" $ testFileName "txt" >>= modifyFileSpec ActionEnv
    it "Remove file" $ testFileName "txt" >>= removeFileSpec ActionEnv
    it "Rename file" $ renameInput        >>= renameFileSpec ActionEnv
    it "Debounce"    $ testFileName "txt" >>= dbFileSpec     ActionEnv
  describe "watchDirChan" $ do
    it "Create file" $ testFileName "txt" >>= createFileSpec ChanEnv
    it "Modify file" $ testFileName "txt" >>= modifyFileSpec ChanEnv
    it "Remove file" $ testFileName "txt" >>= removeFileSpec ChanEnv
    it "Rename file" $ renameInput        >>= renameFileSpec ChanEnv
  describe "watchTree" $ do
    it "Create file (pre-existing directory)" $ testFileName "txt" >>= createFileSpecR1 ActionEnv
    it "Create file (create directory)"       $ testFileName "txt" >>= createFileSpecR2 ActionEnv
    it "Modify file" $ testFileName "txt" >>= modifyFileSpecR ActionEnv
    it "Remove file" $ testFileName "txt" >>= removeFileSpecR ActionEnv
    it "Rename file" $ renameInput        >>= renameFileSpecR ActionEnv
  describe "watchTreeChan" $ do
    it "Create file (pre-existing directory)" $ testFileName "txt" >>= createFileSpecR1 ChanEnv
    it "Create file (create directory)"       $ testFileName "txt" >>= createFileSpecR2 ChanEnv
    it "Modify file" $ testFileName "txt" >>= modifyFileSpecR ChanEnv
    it "Remove file" $ testFileName "txt" >>= removeFileSpecR ChanEnv
    it "Rename file" $ renameInput        >>= renameFileSpecR ChanEnv

createFileSpec :: ChanActionEnv -> FilePath -> Assertion
createFileSpec envType fileName = do
  inEnv envType DirEnv act action $ matchEvents matchers
  where
    action :: FilePath -> IO ()
    action envDir = writeFile (envDir </> fileName) empty
    matchers :: [EventPredicate]
    matchers = [EventPredicate "File creation" (matchCreate fileName)]

modifyFileSpec :: ChanActionEnv -> FilePath -> Assertion
modifyFileSpec envType fileName = do
  withTempDir $ \envDir -> do
    writeFile (envDir </> fileName) empty
    inTempDirEnv envType DirEnv act action (matchEvents matchers) envDir
  where
    action :: FilePath -> IO ()
    action envDir = do
      writeTextFile  (envDir </> fileName) $ pack "Hello world"
    matchers :: [EventPredicate]
    matchers = [EventPredicate "File modification" (matchModify fileName)]

removeFileSpec :: ChanActionEnv -> FilePath -> Assertion
removeFileSpec envType fileName = do
  withTempDir $ \envDir -> do
    writeFile (envDir </> fileName) empty
    inTempDirEnv envType DirEnv act action (matchEvents matchers) envDir
  where
    action :: FilePath -> IO ()
    action envDir = removeFile (envDir </> fileName)
    matchers :: [EventPredicate]
    matchers = [EventPredicate "File deletion" (matchRemove fileName)]

renameFileSpec :: ChanActionEnv -> (FilePath, FilePath) -> Assertion
renameFileSpec envType (oldFileName, newFileName) = do
  withTempDir $ \envDir -> do
    writeFile (envDir </> oldFileName) empty
    inTempDirEnv envType DirEnv act action (matchEvents matchers) envDir
  where
    action :: FilePath -> IO ()
    action envDir = rename (envDir </> oldFileName) (envDir </> newFileName)
    matchers :: [EventPredicate]
    matchers = [ EventPredicate "Rename: File deletion" (matchRemove oldFileName)
               , EventPredicate "Rename: File creation" (matchCreate newFileName) ]

-- TODO: This is a weak test. What we actually need is an interface for
-- "anti-matchers" to ensure that certain events do NOT get reported.
dbFileSpec :: ChanActionEnv -> FilePath -> Assertion
dbFileSpec envType _ = do
  chan <- newChan
  inChanEnv envType DirEnv act (action chan) (matchEvents matchers) chan
  where
    action :: EventChannel -> FilePath -> IO ()
    action chan _ = do
      writeChan chan e1
      writeChan chan e2
    matchers :: [EventPredicate]
    matchers = [EventPredicate "First debounced event" (\e -> e == e1)]
    e1 :: Event
    e1 = Added (fp "") (posixSecondsToUTCTime 0)
    e2 :: Event
    e2 = Modified (fp "") (posixSecondsToUTCTime 0)

createFileSpecR1 :: ChanActionEnv -> FilePath -> Assertion
createFileSpecR1 envType fileName = do
  withTempDir $ \envDir -> do
    withNestedTempDir envDir $ \envPath -> do
      inTempDirEnv envType TreeEnv act (action envPath) (matchEvents matchers) envDir
  where
    action :: FilePath -> FilePath -> IO ()
    action envPath _ = do
      writeFile (envPath </> fileName) empty
    matchers :: [EventPredicate]
    matchers = [EventPredicate "File creation" (matchCreate fileName)]

createFileSpecR2 :: ChanActionEnv -> FilePath -> Assertion
createFileSpecR2 envType fileName = do
  withTempDir $ \envDir -> do
    inTempDirEnv envType TreeEnv act (action envDir) (matchEvents matchers) envDir
  where
    action :: FilePath -> FilePath -> IO ()
    action envDir _ = do
      withNestedTempDir envDir $ \envPath -> writeFile (envPath </> fileName) empty
    matchers :: [EventPredicate]
    matchers = [EventPredicate "File creation" (matchCreate fileName)]

modifyFileSpecR :: ChanActionEnv -> FilePath -> Assertion
modifyFileSpecR envType fileName = do
  withTempDir $ \envDir -> do
    withNestedTempDir envDir $ \envPath -> do
      writeFile (envPath </> fileName) empty
      inTempDirEnv envType TreeEnv act (action envPath) (matchEvents matchers) envDir
  where
    action :: FilePath -> FilePath -> IO ()
    action envPath _ = do
      writeTextFile  (envPath </> fileName) $ pack "Hello world"
    matchers :: [EventPredicate]
    matchers = [EventPredicate "File deletion" (matchModify fileName)]

removeFileSpecR :: ChanActionEnv -> FilePath -> Assertion
removeFileSpecR envType fileName = do
  withTempDir $ \envDir -> do
    withNestedTempDir envDir $ \envPath -> do
      writeFile (envPath </> fileName) empty
      inTempDirEnv envType TreeEnv act (action envPath) (matchEvents matchers) envDir
  where
    action :: FilePath -> FilePath -> IO ()
    action envPath _ = do
      removeFile (envPath </> fileName)
    matchers :: [EventPredicate]
    matchers = [EventPredicate "File deletion" (matchRemove fileName)]

renameFileSpecR :: ChanActionEnv -> (FilePath, FilePath) -> Assertion
renameFileSpecR envType (oldFileName, newFileName) = do
  withTempDir $ \envDir -> do
    withNestedTempDir envDir $ \envPath -> do
      writeFile (envPath </> oldFileName) empty
      inTempDirEnv envType TreeEnv act (action envPath) (matchEvents matchers) envDir
  where
    action :: FilePath -> FilePath -> IO ()
    action envPath _ = rename (envPath </> oldFileName) (envPath </> newFileName)
    matchers :: [EventPredicate]
    matchers = [ EventPredicate "Rename: File deletion" (matchRemove oldFileName)
               , EventPredicate "Rename: File creation" (matchCreate newFileName) ]

renameInput :: IO (FilePath, FilePath)
renameInput = do
  oldName <- testFileName "txt"
  newName <- testFileName "txt"
  return (oldName, newName)

matchCreate :: FilePath -> Event -> Bool
matchCreate fileName (Added path _) = matchFP pattern path
  where
    pattern = compile $  "**/*" ++ fp fileName
matchCreate _ _ = False

matchModify :: FilePath -> Event -> Bool
matchModify fileName (Modified path _) = matchFP pattern path
  where
    pattern = compile $  "**/*" ++ fp fileName
matchModify _ _ = False

matchRemove :: FilePath -> Event -> Bool
matchRemove fileName (Removed path _) = matchFP pattern path
  where
    pattern = compile $  "**/*" ++ fp fileName
matchRemove _ _ = False

matchFP :: Pattern -> FilePath -> Bool
matchFP pattern path = match pattern $ fp path
