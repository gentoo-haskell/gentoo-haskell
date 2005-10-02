module Action where

import Config
import Error

import Control.Monad.State
import Control.Monad.Error
import System.IO
import System.Environment

type HPAction = ErrorT HackPortError (StateT (Config,Int) IO)

verbose :: HPAction a -> (String,a->String) -> HPAction a
verbose action (premsg,postmsg) = do
	echoIndent
	echo premsg
	flush
	res <- indent action
	echoIndent
	echoLn (postmsg res)
	return res

sayNormal :: HPAction a -> (String,a->String) -> HPAction a
sayNormal action strs = do
	cfg <- getCfg
	case verbosity cfg of
		Silent -> action
		_ -> action `verbose` strs

sayDebug :: HPAction a -> (String,a->String) -> HPAction a
sayDebug action strs = do
	cfg <- getCfg
	case verbosity cfg of
		Debug -> action `verbose` strs
		_ -> action

info :: String -> HPAction ()
info str = do
	cfg <- getCfg
	case verbosity cfg of
		Silent -> return ()
		_ -> echoLn str

getCfg :: HPAction Config
getCfg = get >>= return.fst

lessIndent :: HPAction ()
lessIndent = get >>= \(cfg,ind)->put (cfg,ind-1)

moreIndent :: HPAction ()
moreIndent = get >>= \(cfg,ind)->put (cfg,ind+1)

echoIndent :: HPAction ()
echoIndent = get >>= \(_,ind)->echo (replicate ind '\t')

indent :: HPAction a -> HPAction a
indent action = do
	moreIndent
	res <- action
	lessIndent
	return res

echo :: String -> HPAction ()
echo str = liftIO $ hPutStr stderr str

flush :: HPAction ()
flush = liftIO (hFlush stderr)

echoLn :: String -> HPAction ()
echoLn str = echoIndent >> echo str >> liftIO (hPutChar stderr '\n')

loadConfig :: HPAction OperationMode
loadConfig = do
	args <- liftIO getArgs
	case parseConfig args of
		Left errmsg -> throwError (ArgumentError errmsg)
		Right (cfg,opmode) -> get >>= \(_,ind) -> put (cfg,ind) >> return opmode

performHPAction :: HPAction a -> IO ()
performHPAction action = do
	res <- evalStateT (runErrorT action) (defaultConfig,0)
	case res of
		Left err -> hPutStr stderr (hackPortShowError err)
		Right _ -> return ()
