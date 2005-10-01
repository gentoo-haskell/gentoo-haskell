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
		mul -> search mul
  where
  search mul = do
    let loop [] = throwDyn $ MultipleOverlays mul
        loop (x:xs) = do
          found <- doesFileExist (x ++ "/.hackagecache.xml")
          if found
            then return x
            else loop xs
    putStrLn "There are several overlays in your /etc/make.conf"
    putStr $ unlines $ map (" * " ++) mul
    putStrLn "Looking for one with a HackPort cache..."
    overlay <- loop mul
    putStrLn ("I choose " ++ overlay ++ 
              "\nOverride my decision with hackport -p /my/overlay")
    return overlay

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
