module Verbosity where

import System.IO

data Verbosity
	= Debug
	| Normal
	| Silent

verboseNormal :: Verbosity -> IO a -> (String,a->String) -> IO a
verboseNormal verb action msg = case verb of
	Silent -> action
	_ -> verbose action msg

verboseDebug :: Verbosity -> IO a -> (String,a->String) -> IO a
verboseDebug verb action msg = case verb of
	Silent -> action
	Normal -> action
	_ -> verbose action msg

verbose :: IO a -> (String,a->String) -> IO a
verbose action (premsg,postmsg) = do
	hPutStr stderr premsg
	hFlush stderr
	res <- action
	hPutStr stderr (postmsg res)
	hFlush stderr
	return res
