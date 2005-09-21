module Bash where

import Control.Exception
import System.Process
import System.Directory
import System.IO
import System.Exit
import Error

getOverlay :: IO String
getOverlay = do
	overlays <- getOverlays
	case overlays of
		[] -> throwDyn NoOverlay
		[x] -> return x
		mul -> throwDyn $ MultipleOverlays mul

getOverlays :: IO [String]
getOverlays = runBash "source /etc/make.conf;echo -n $PORTDIR_OVERLAY" >>= (return.words)

runBash ::
	String -> -- ^ The command line
	IO String -- ^ The command-line's output
runBash command = do
	mpath <- findExecutable "bash"
	bash <- maybe (throwDyn BashNotFound) return mpath
	(inp,outp,err,pid) <- runInteractiveProcess bash ["-c",command] Nothing Nothing
	hClose inp
	result <- hGetContents outp
	errors <- hGetContents err
	length result `seq` hClose outp
	length errors `seq` hClose err
	exitCode <- waitForProcess pid
	case exitCode of
		ExitFailure err -> throwDyn $ BashError errors
		ExitSuccess -> return result
