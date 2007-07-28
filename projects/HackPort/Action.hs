module Action where

import Config
import Error

import Control.Monad.State
import Control.Monad.Error
import Network.URI (parseURI)
import System.IO
import System.Environment

type HPAction = ErrorT HackPortError (StateT HPState IO)

data HPState = HPState
	{ config :: Config
	, indention :: Int
	}

verbose :: HPAction a -> (String,a->String) -> HPAction a
verbose action (premsg,postmsg) = do
	echoIndent
	echo premsg
	flush
	res <- indent action
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

-- | Prints a string iff in debug output mode
whisper :: String -> HPAction ()
whisper str = do
	cfg <- getCfg
	case verbosity cfg of
		Debug -> echoLn str
		_ -> return ()

getCfg :: HPAction Config
getCfg = gets config

setPortageTree :: Maybe String -> HPAction ()
setPortageTree mt = modify $ \hps -> 
	hps { config = (config hps) { portageTree = mt } }

lessIndent :: HPAction ()
lessIndent = modify $ \s -> s { indention = indention s - 1 }

moreIndent :: HPAction ()
moreIndent = modify $ \s -> s { indention = indention s + 1 }

echoIndent :: HPAction ()
echoIndent = do
	ind <- gets indention
	echo (replicate ind '\t')

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
		Right (opts,opmode) -> do
			cfg <- foldM optionToConfig defaultConfig opts
			modify $ \s -> s { config = cfg }
			return opmode

optionToConfig :: Config -> HackPortOptions -> HPAction Config
optionToConfig cfg opt = case opt of
	PortageTree str -> return cfg { portageTree = Just str }
	Category str -> return cfg { portageCategory = str }
	Server str -> case parseURI str of
		Nothing -> throwError (InvalidServer str)
		Just uri -> return cfg { server = uri }
	TempDir str -> return cfg { tmp = str }
	Verbosity str -> case parseVerbosity str of
		Nothing -> throwError (UnknownVerbosityLevel str)
		Just verb -> return cfg { verbosity=verb }

performHPAction :: HPAction a -> IO ()
performHPAction action = do
	res <- evalStateT (runErrorT action) (HPState defaultConfig 0)
	case res of
		Right _ -> return ()
		Left err -> do
			hPutStrLn stderr "An error occurred. To get more info run with --verbosity=debug"
			hPutStrLn stderr (hackPortShowError err)
