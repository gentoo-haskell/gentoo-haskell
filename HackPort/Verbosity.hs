module Verbosity where

data Verbosity
	= Debug
	| Normal
	| Silent

verboseNormal :: Verbosity -> IO a -> String -> IO a
verboseNormal verb action msg = case verb of
	Silent -> action
	_ -> putStr msg >> action

verboseDebug :: Verbosity -> IO a -> String -> IO a
verboseDebug verb action msg = case verb of
	Silent -> action
	Normal -> action
	_ -> putStr msg >> action
