module Main where

import System.Environment
import System.Exit
import Distribution.Package
import Data.Version
import Control.Exception
import Data.Typeable
import System.IO
import Data.Char
import qualified Data.Set as Set

import Error
import Query
import GenerateEbuild
import Cabal2Ebuild
import Bash
import Config
import Verbosity
import Diff
import Portage

getPortageTree :: Config -> IO String
getPortageTree cfg = case portageTree cfg of
	Nothing -> getOverlay `sayDebug` ("Guessing overlay from /etc/make.conf... ",\tree->"Found '"++tree++"'\n")
	Just tree -> return tree
	where
	sayDebug=verboseDebug (verbosity cfg)

listAll :: Config -> IO ()
listAll cfg = do
	pkgs <- getPackages (verbosity cfg) (server cfg)
	putStr (unlines pkgs)

query :: Config -> String -> IO ()
query cfg name = do
	pkgvers <- getPackageVersions (verbosity cfg) (server cfg) name
	putStr (unlines (map showVersion pkgvers))

merge :: Config -> String -> String -> IO ()
merge cfg name vers = do
	portTree <- getPortageTree cfg
	case parseVersion' vers of
		Nothing -> putStr ("Error: couldn't parse version number '"++vers++"'\n")
		Just realvers -> do
			ebuild <- hackage2ebuild (verbosity cfg) (tarCommand cfg) (server cfg) (tmp cfg) (verify cfg) (PackageIdentifier {pkgName=name,pkgVersion=realvers})
			mergeEbuild (verbosity cfg) portTree (portageCategory cfg) ebuild
	where
	sayDebug = verboseDebug (verbosity cfg)
	sayNormal = verboseNormal (verbosity cfg)

diff :: Config -> IO ()
diff cfg = do
	serverPkgs <- getPackageIdentifiers (server cfg)
		`sayDebug` ("Getting package list from '"++(server cfg)++"'... ",const "done.\n")
	let serverPkgs'=map (\pkg->pkg {pkgName=map toLower (pkgName pkg)}) serverPkgs
	portTree <- getPortageTree cfg
	portagePkgs <- portageGetPackages portTree (portageCategory cfg)
	let pkgDiff=diffSet (Set.fromList portagePkgs) (Set.fromList serverPkgs')
	putStr $ unlines $ map (\(DiffResult action pkg)->(case action of
		Add->'+'
		Remove->'-'
		Stay->'='):(pkgName pkg++"-"++showVersion (pkgVersion pkg))) (Set.elems pkgDiff)
	where
	sayDebug = verboseDebug (verbosity cfg)

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
			Merge pkg vers -> merge config pkg vers
			DiffTree -> diff config) `catchDyn` (\x->report (hackPortShowError (server config) x))
	where
	report err = hPutStr stderr (err++"\n")

instance Ord PackageIdentifier where
	compare pkg1 pkg2 = case compare (pkgName pkg1) (pkgName pkg2) of
		EQ -> compare (pkgVersion pkg1) (pkgVersion pkg2)
		x -> x
