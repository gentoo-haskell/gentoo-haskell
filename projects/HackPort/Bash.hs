module Bash where

import Control.Monad.Trans
import Control.Monad.Error
import System.Process
import System.Directory
import System.IO
import System.Exit

import Action
import Error

getOverlay :: HPAction String
getOverlay = do
	overlays <- getOverlays
	case overlays of
		[] -> throwError NoOverlay
		[x] -> return x
		mul -> search mul
  where
  search :: [String] -> HPAction String
  search mul = do
    let loop [] = throwError $ MultipleOverlays mul
        loop (x:xs) = (do
          found <- liftIO (doesFileExist (x ++ "/.hackagecache.xml"))
	  	`sayDebug` ("Checking '"++x++"'...\n",\res->if res then "found.\n" else "not found.")
          if found
            then return x
            else loop xs) 
    whisper "There are several overlays in your /etc/make.conf"
    mapM (\x-> whisper (" * " ++x)) mul
    whisper "Looking for one with a HackPort cache..."
    overlay <- loop mul
    whisper ("I choose " ++ overlay) 
    whisper "Override my decision with hackport -p /my/overlay"
    return overlay

getOverlays :: HPAction [String]
getOverlays = runBash "source /etc/make.conf;echo -n $PORTDIR_OVERLAY" >>= (return.words)

getPortDir :: HPAction String
getPortDir = do
	dir <- runBash "source /etc/make.conf;echo -n $PORTDIR"
	case dir of
		"" -> return "/usr/portage"
		_ -> return dir

runBash ::
	String -> -- ^ The command line
	HPAction String -- ^ The command-line's output
runBash command = do
	mpath <- liftIO $ findExecutable "bash"
	bash <- maybe (throwError BashNotFound) return mpath
	(inp,outp,err,pid) <- liftIO $ runInteractiveProcess bash ["-c",command] Nothing Nothing
	liftIO $ hClose inp
	result <- liftIO $ hGetContents outp
	errors <- liftIO $ hGetContents err
	length result `seq` liftIO (hClose outp)
	length errors `seq` liftIO (hClose err)
	exitCode <- liftIO $ waitForProcess pid
	case exitCode of
		ExitFailure err -> throwError $ BashError errors
		ExitSuccess -> return result
