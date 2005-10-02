module Main where

import System.Environment
import System.Exit
import Distribution.Package
import Data.Version
import Control.Monad.Trans
import Control.Monad.Error
import Data.Typeable
import System.IO
import Data.Char
import Data.List
import qualified Data.Set as Set

import Action
import Error
import GenerateEbuild
import Cabal2Ebuild
import Bash
import Config
import Diff
import Portage
import Cache
import MaybeRead

readCache' :: FilePath -> HPAction Cache
readCache' portDir = let target=portDir++"/.hackagecache.xml" in readCache (portDir++"/.hackagecache.xml")
		`sayDebug` ("Reading cache from '"++target++"'...",const "done.")

getPortageTree :: HPAction String
getPortageTree = do
	cfg <- getCfg
	case portageTree cfg of
		Nothing -> getOverlay `sayDebug` ("Guessing overlay from /etc/make.conf...",\tree->"Found '"++tree++"'")
		Just tree -> return tree

listAll :: HPAction ()
listAll = do
	cache <- getPortageTree >>= readCache'
	liftIO $ putStr (unlines (map (showPackageId.(\(pkg,_,_)->pkg)) (packages cache)))

query :: String -> HPAction ()
query name = do
	portTree <- getPortageTree
	cache <- readCache' portTree
	let pkgs = filter (\(PackageIdentifier {pkgName=str},_,_)->str==name) (packages cache)
	if null pkgs then throwError (PackageNotFound (Left name)) else liftIO (putStr (unlines (map (showVersion.pkgVersion.(\(pkg,_,_)->pkg)) pkgs)))

merge :: PackageIdentifier -> HPAction ()
merge pid = do
	portTree <- getPortageTree
	cache <- readCache' portTree
	rpid <- maybe (throwError (PackageNotFound (Right pid))) (return.id) (find (\(pkg,_,_)->pkg==pid) (packages cache))
	ebuild <- hackage2ebuild rpid
	mergeEbuild portTree ebuild

diff :: HPAction ()
diff = do
	cfg <- getCfg
	portTree <- getPortageTree
	cache <- readCache' portTree
	let serverPkgs'=map (\(pkg,_,_)->pkg {pkgName=map toLower (pkgName pkg)}) (packages cache)
	portTree <- getPortageTree
	portagePkgs <- portageGetPackages portTree
	let pkgDiff=diffSet (Set.fromList portagePkgs) (Set.fromList serverPkgs')
	liftIO $ putStr $ unlines $ map (\(DiffResult action pkg)->(case action of
		Add->'+'
		Remove->'-'
		Stay->'='):(pkgName pkg++"-"++showVersion (pkgVersion pkg))) (Set.elems pkgDiff)

update :: HPAction ()
update = do
	cfg <- getCfg
	portTree <- getPortageTree
	cache <- liftIO (getCacheFromServer (server cfg))
		`sayNormal` ("Getting package list from '"++(server cfg)++"'... ",const "done.\n")
	let writeT = portTree++"/.hackagecache.xml"
	liftIO (writeCache writeT cache)
		`sayDebug` ("Writing cache to '"++writeT++"'... ",const "done.\n")

hpmain :: HPAction ()
hpmain = do
	mode <- loadConfig
	case mode of
		ShowHelp -> liftIO hackageUsage
		ListAll -> listAll
		Query pkg -> query pkg
		Merge pkg -> merge pkg
		DiffTree -> diff
		Update -> update

main :: IO ()
main = performHPAction hpmain

instance Ord PackageIdentifier where
	compare pkg1 pkg2 = case compare (pkgName pkg1) (pkgName pkg2) of
		EQ -> compare (pkgVersion pkg1) (pkgVersion pkg2)
		x -> x
