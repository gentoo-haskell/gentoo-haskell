module Main where

import System.Environment
import System.Exit
import Distribution.Package
import Data.Version
import Control.Exception
import Data.Typeable
import System.IO
import Data.Char
import Data.List
import qualified Data.Set as Set

import Error
import GenerateEbuild
import Cabal2Ebuild
import Bash
import Config
import Verbosity
import Diff
import Portage
import Cache
import MaybeRead

readCache' :: Config -> FilePath -> IO Cache
readCache' cfg portDir = let target=portDir++"/.hackagecache.xml" in readCache (portDir++"/.hackagecache.xml")
		`sayDebug` ("Reading cache from '"++target++"'...",const "done.\n") where
	sayDebug = verboseDebug (verbosity cfg)

getPortageTree :: Config -> IO String
getPortageTree cfg = case portageTree cfg of
	Nothing -> getOverlay `sayDebug` ("Guessing overlay from /etc/make.conf... ",\tree->"Found '"++tree++"'\n")
	Just tree -> return tree
	where
	sayDebug=verboseDebug (verbosity cfg)

listAll :: Config -> IO ()
listAll cfg = do
	portTree <- getPortageTree cfg
	cache <- readCache' cfg portTree
	putStr (unlines (map (showPackageId.(\(pkg,_,_)->pkg)) (packages cache)))

query :: Config -> String -> IO ()
query cfg name = do
	portTree <- getPortageTree cfg
	cache <- readCache' cfg portTree
	let pkgs = filter (\(PackageIdentifier {pkgName=str},_,_)->str==name) (packages cache)
	if null pkgs then throwDyn (PackageNotFound (Left name)) else putStr (unlines (map (showVersion.pkgVersion.(\(pkg,_,_)->pkg)) pkgs))

merge :: Config -> PackageIdentifier -> IO ()
merge cfg pid = do
	portTree <- getPortageTree cfg
	cache <- readCache' cfg portTree
	let rpid = maybe (throwDyn (PackageNotFound (Right pid))) id (find (\(pkg,_,_)->pkg==pid) (packages cache))
	ebuild <- hackage2ebuild (verbosity cfg) (tarCommand cfg) (tmp cfg) (verify cfg) rpid
	mergeEbuild (verbosity cfg) portTree (portageCategory cfg) ebuild
	where
	sayDebug = verboseDebug (verbosity cfg)
	sayNormal = verboseNormal (verbosity cfg)

diff :: Config -> IO ()
diff cfg = do
	portTree <- getPortageTree cfg
	cache <- readCache' cfg portTree
	let serverPkgs'=map (\(pkg,_,_)->pkg {pkgName=map toLower (pkgName pkg)}) (packages cache)
	portTree <- getPortageTree cfg
	portagePkgs <- portageGetPackages portTree (portageCategory cfg)
	let pkgDiff=diffSet (Set.fromList portagePkgs) (Set.fromList serverPkgs')
	putStr $ unlines $ map (\(DiffResult action pkg)->(case action of
		Add->'+'
		Remove->'-'
		Stay->'='):(pkgName pkg++"-"++showVersion (pkgVersion pkg))) (Set.elems pkgDiff)
	where
	sayDebug = verboseDebug (verbosity cfg)

update :: Config -> IO ()
update cfg = do
	portTree <- getPortageTree cfg
	cache <- getCacheFromServer (server cfg)
		`sayDebug` ("Getting package list from '"++(server cfg)++"'... ",const "done.\n")
	let writeT = portTree++"/.hackagecache.xml"
	writeCache writeT cache
		`sayDebug` ("Writing cache to '"++writeT++"'... ",const "done.\n")
	where
	sayDebug=verboseDebug (verbosity cfg)

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
			Merge pkg -> merge config pkg
			DiffTree -> diff config
			Update -> update config) `catchDyn` (\x->report (hackPortShowError (server config) x))
	where
	report err = hPutStr stderr (err++"\n")

instance Ord PackageIdentifier where
	compare pkg1 pkg2 = case compare (pkgName pkg1) (pkgName pkg2) of
		EQ -> compare (pkgVersion pkg1) (pkgVersion pkg2)
		x -> x
