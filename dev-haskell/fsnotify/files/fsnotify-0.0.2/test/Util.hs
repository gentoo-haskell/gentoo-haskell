--
-- Copyright (c) 2012 Mark Dittmer - http://www.markdittmer.org
-- Developed for a Google Summer of Code project - http://gsoc2012.markdittmer.org
--

module Util where

import Prelude hiding (FilePath, catch, pred)

import Control.Concurrent (threadDelay)
import Control.Concurrent.Chan
import Control.Concurrent.MVar (MVar, newMVar, readMVar, swapMVar)
import Control.Exception
import Control.Monad (when)
import Data.Unique.Id
import Filesystem.Path.CurrentOS hiding (concat)
import System.Directory
import System.IO.Error (isPermissionError)
import System.FSNotify
import System.FSNotify.Path
import System.FSNotify.Types
import System.Random
import System.Timeout (timeout)

data ChanActionEnv =
    ChanEnv
  | ActionEnv
data DirTreeEnv =
    DirEnv
  | TreeEnv
data TestContext = TestContext ChanActionEnv DirTreeEnv ActionPredicate

data TestReport = TestReport FilePath [Event] deriving (Show)
data TestResult = TestResult Bool String TestReport deriving (Show)
type TestAction = FilePath -> IO ()
type MTestResult = MVar TestResult
type TestCase = MTestResult -> IO ()
type CurriedEventProcessor = TestReport -> IO (TestResult)
type EventProcessor = MTestResult -> CurriedEventProcessor
data EventPredicate = EventPredicate String (Event -> Bool)

void :: IO ()
void = return ()

predicateName :: EventPredicate -> String
predicateName (EventPredicate name _) = name

matchEvents :: [EventPredicate] -> EventProcessor
matchEvents preds mVar report@(TestReport _ events) =
  swapMVar mVar result >> return result
  where
    matchMatrix :: [[Bool]]
    matchMatrix = map (\(EventPredicate _ pred) -> map (\event -> pred event) events) preds
    matchList :: [Bool]
    matchList = map (\lst -> any id lst) matchMatrix
    errorList :: [(Bool, String)]
    errorList = zip matchList (map (\(EventPredicate errStr _) -> errStr) preds)
    errorString :: String
    errorString = foldl foldError "" errorList
    foldError :: String -> (Bool, String) -> String
    foldError accStr (success, errStr) = if not success then accStr ++ " " ++ errStr else accStr
    status :: Bool
    status = all id matchList
    result =   if status then
                 TestResult status "" report
               else
                 TestResult status ("Failed to match events: " ++ errorString) report

newId :: IO String
newId = randomIO >>= initIdSupply >>= return . show . hashedId . idFromSupply

testFileName :: String -> IO FilePath
testFileName ext = do
  uId <- newId
  return $ fp ("test-" ++ uId ++ "." ++ ext)

testName :: IO FilePath
testName = do
  uId <- newId
  return $ fp ("sandbox-" ++ uId) </> empty

dirPreAction :: Int
dirPreAction = 500000

-- Delay to keep temporary directories around long enough for events to be
-- picked up by OS (in microseconds)
dirPostAction :: Int
dirPostAction = 500000

withTempDir :: (FilePath -> IO ()) -> IO ()
withTempDir fn = withNestedTempDir empty fn

withNestedTempDir :: FilePath -> (FilePath -> IO ()) -> IO ()
withNestedTempDir firstPath fn = do
  secondPath <- testName
  let path = if firstPath /= empty then
               fp $ firstPath </> secondPath
             else
               fp secondPath
  bracket (createDirectory path >> threadDelay dirPreAction >> return path) (attemptDirectoryRemoval . fp) (fn . fp)

attemptDirectoryRemoval :: FilePath -> IO ()
attemptDirectoryRemoval path = do
  threadDelay dirPostAction
  catch
    (removeDirectoryRecursive pathString)
    (\e -> when
           (not $ isPermissionError e)
           (throw e))
  where
    pathString = fp path

performAction :: TestAction -> FilePath -> IO ()
performAction action path = action path

reportOnAction :: FilePath -> EventChannel -> CurriedEventProcessor -> IO TestResult
reportOnAction = reportOnAction' []

reportOnAction' :: [Event] -> FilePath -> EventChannel -> CurriedEventProcessor -> IO TestResult
reportOnAction' events path chan processor = do
  result@(TestResult status _ _) <- processor (TestReport path events)
  if not status then do
    event <- readChan chan
    reportOnAction' (event:events) path chan processor
    else
    return result

actAndReport :: TestAction -> FilePath -> EventChannel -> CurriedEventProcessor -> IO TestResult
actAndReport action path chan processor = do
  performAction action path
  reportOnAction path chan processor

testTimeout :: Int
testTimeout = 3000000

timeoutTest :: MTestResult -> Maybe () -> IO ()
timeoutTest mResult Nothing = do
  result <- readMVar mResult
  error $ "TIMEOUT: Last test result: " ++ show result
timeoutTest mResult (Just _) = do
  result <- readMVar mResult
  case result of
    (TestResult False _ _) -> error $ show result
    (TestResult True  _ _) -> void

runTest :: TestCase -> IO ()
runTest test = do
  mVar <- newMVar $ TestResult False "Timeout with no test result" (TestReport empty [])
  timeout testTimeout (test mVar) >>= timeoutTest mVar

inEnv :: ChanActionEnv -> DirTreeEnv -> ActionPredicate -> TestAction -> EventProcessor -> IO ()
inEnv caEnv dtEnv reportPred action eventProcessor =
  withTempDir $ inTempDirEnv caEnv dtEnv reportPred action eventProcessor

inTempDirEnv :: ChanActionEnv -> DirTreeEnv -> ActionPredicate -> TestAction -> EventProcessor-> FilePath -> IO ()
inTempDirEnv caEnv dtEnv reportPred action eventProcessor path =
  withManagerConf NoDebounce $ \manager -> do
    chan <- newChan
    inTempDirChanEnv caEnv dtEnv reportPred action eventProcessor path manager chan

inChanEnv :: ChanActionEnv -> DirTreeEnv -> ActionPredicate -> TestAction -> EventProcessor -> EventChannel -> IO ()
inChanEnv caEnv dtEnv reportPred action eventProcessor chan =
  withTempDir $ \path -> do
    withManagerConf NoDebounce $ \manager -> do
      inTempDirChanEnv caEnv dtEnv reportPred action eventProcessor path manager chan

inTempDirChanEnv :: ChanActionEnv -> DirTreeEnv -> ActionPredicate -> TestAction -> EventProcessor-> FilePath -> WatchManager -> EventChannel -> IO ()
inTempDirChanEnv caEnv dtEnv reportPred action eventProcessor path manager chan = do
    watchInEnv caEnv dtEnv manager path reportPred chan
    runTest $ \mVar -> do
      _ <- actAndReport action path chan $ eventProcessor mVar
      void
    void

actionAsChan :: (WatchManager -> FilePath -> ActionPredicate -> Action       -> IO ()) ->
                 WatchManager -> FilePath -> ActionPredicate -> EventChannel -> IO ()
actionAsChan actionFunction wm path ap ec = actionFunction wm path ap (writeChan ec)

watchInEnv :: ChanActionEnv
           -> DirTreeEnv
           -> WatchManager
           -> FilePath
           -> ActionPredicate
           -> EventChannel
           -> IO ()
watchInEnv ChanEnv   DirEnv  = watchDirChan
watchInEnv ChanEnv   TreeEnv = watchTreeChan
watchInEnv ActionEnv DirEnv  = actionAsChan watchDir
watchInEnv ActionEnv TreeEnv = actionAsChan watchTree
