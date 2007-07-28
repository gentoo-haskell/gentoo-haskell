module Cache where

import Action
import Portage
import Config
import Error
import Index

import Network.URI
import Network.HTTP
import Data.ByteString.Lazy as BS
import System.Time
import System.FilePath
import Control.Monad.Error(throwError)
import Control.Monad.Trans(liftIO)
import Control.Monad (unless)
import System.Directory (doesFileExist)

-- | A long time. Used in checkCacheDate
alarmingLongTime :: TimeDiff
alarmingLongTime = TimeDiff
	{ tdYear = 0
	, tdMonth = 0
	, tdDay = 7
	, tdHour = 0
	, tdMin = 0
	, tdSec = 0
	, tdPicosec = 0
	}

cacheURI :: URI -> URI
cacheURI uri = uri {uriPath = uriPath uri++"/00-index.tar.gz"}

updateCache :: HPAction ()
updateCache = do
	tree <- getPortageTree
	let cacheFile = tree </> "00-index.tar.gz"
	cfg <- getCfg
	let cache = cacheURI $ server cfg
	res <- (liftIO $ simpleHTTP (Request cache GET [] "")) `sayNormal` ("Fetching cache from "++show cache++"...",const "done.")
	case res of
		Left err -> throwError (ConnectionFailed (show cache) (show err))
		Right resp -> liftIO $ Prelude.writeFile cacheFile (rspBody resp)

readCache :: FilePath -> HPAction Index
readCache portdir = do
	let cacheFile = portdir </> "00-index.tar.gz"
	exists <- liftIO $ doesFileExist cacheFile
	unless exists $ throwError NoCache
	str <- liftIO $ BS.readFile cacheFile
	return $ readIndex str
