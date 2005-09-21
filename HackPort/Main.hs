module Main where

import System.Environment
import System.Exit
import Distribution.Package
import Data.Version
import Control.Exception
import Data.Typeable
import Error
import Query
import GenerateEbuild
import Cabal2Ebuild
import Bash
import Config
import Verbosity

listAll :: Config -> IO ()
listAll cfg = do
	pkgs <- getPackages (server cfg)
	putStr (unlines pkgs)

query :: Config -> String -> IO ()
query cfg name = do
	pkgvers <- getPackageVersions (server cfg) name
	putStr (unlines (map showVersion pkgvers))

merge :: Config -> String -> String -> IO ()
merge cfg name vers = do
	portTree <- case portageTree cfg of
		Nothing -> getOverlay `sayDebug` "Guessing overlay from /etc/make.conf...\n"
		Just tree -> return tree
	case parseVersion' vers of
		Nothing -> putStr ("Error: couldn't parse version number '"++vers++"'\n")
		Just realvers -> do
			ebuild <- hackage2ebuild (tarCommand cfg) (server cfg) (tmp cfg) (verify cfg) (PackageIdentifier {pkgName=name,pkgVersion=realvers})
			mergeEbuild (verbosity cfg) portTree (portageCategory cfg) ebuild
	where
	sayDebug = verboseDebug (verbosity cfg)
	sayNormal = verboseNormal (verbosity cfg)

main :: IO ()
main = do
	args <- getArgs
	case parseConfig args of
		Left err -> do
			putStr err
			exitWith (ExitFailure 1)
		Right (config,mode) -> (case mode of
			ShowHelp -> hackageUsage
			ListAll -> listAll config
			Query pkg -> query config pkg
			Merge pkg vers -> merge config pkg vers) `catchDyn` (\x->putStr ((hackPortShowError (server config) Nothing x)++"\n"))
