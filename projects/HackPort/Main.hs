module Main where

import System.Environment
import System.Exit
import Distribution.Package
import Distribution.PackageDescription
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
import Cabal2Ebuild
import GenerateEbuild
import Bash
import Config
import Diff
import Portage
import Cache
import Index
import MaybeRead

listAll :: HPAction ()
listAll = do
	cache <- getPortageTree >>= readCache
	liftIO $ putStr $ unlines 
		[ name++"-"++vers | (name,vers,_) <- cache ]

query :: String -> HPAction ()
query name = do
	portTree <- getPortageTree
	cache <- readCache portTree
	let pkgs = searchIndex (\str _ -> str==name) cache
	if null pkgs
		then throwError (PackageNotFound (Left name))
		else liftIO (putStr (unlines (map (showVersion.pkgVersion.package) pkgs)))

merge :: PackageIdentifier -> HPAction ()
merge pid = do
	portTree <- getPortageTree
	cache <- readCache portTree
	whisper $ "Searching for: "++pkgName pid++"-"++showVersion (pkgVersion pid)
	let pkgs = searchIndex (\name vers -> name == pkgName pid && vers == showVersion (pkgVersion pid)) cache
	case pkgs of
		[] -> throwError (PackageNotFound (Right pid))
		[pkg] -> do 
			ebuild <- fixSrc pid (cabal2ebuild pkg)
			mergeEbuild portTree ebuild

diff :: DiffMode -> HPAction ()
diff mode = do
	cfg <- getCfg
	portTree <- getPortageTree
	cache <- readCache portTree
	let serverPkgs'=map (\(_,_,pd)-> (package pd) {pkgName=map toLower (pkgName $ package pd)}) cache
	portTree <- getPortageTree
	portagePkgs <- portageGetPackages portTree
	let (inport,inhack,inboth)=diffSet (Set.fromList portagePkgs) (Set.fromList serverPkgs')
	let showPkgSet set = mapM_ (\pkg->echoLn (pkgName pkg++"-"++showVersion (pkgVersion pkg))) (Set.elems set)
	let vindent = case verbosity cfg of
		Silent -> id
		_ -> indent
	when (mode==ShowAll || mode==ShowMissing) (do
		info "Packages in hackage, but not in the overlay:"
		vindent $ showPkgSet inhack)
	when (mode==ShowAll || mode==ShowAdditions) (do
		info "Packages in the overlay, but not in hackage:"
		vindent $ showPkgSet inport)
	when (mode==ShowAll || mode==ShowCommon) (do
		info "Packages in the overlay and hackage:"
		vindent $ showPkgSet inboth)

update :: HPAction ()
update = do
	updateCache
	return ()

overlayonly :: Maybe String -> HPAction ()
overlayonly pd = do
	cfg <- getCfg
	portdir <- maybe (getPortDir `sayDebug` ("Guessing portage main dir from /etc/make.conf...",\res->"found: "++res++".")) return pd
	overlay <- getPortageTree
	mainlinepkgs <- portageGetPackages portdir
		`sayDebug` ("Getting package list from "++portdir++"...",const "done.")
	overlaypkgs <- portageGetPackages overlay
		`sayDebug` ("Getting package list from "++overlay++"...",const "done.")
	info "These packages are in the overlay but not in the portage tree:"
	let (_,diff,_) = diffSet (Set.fromList mainlinepkgs) (Set.fromList overlaypkgs)
	let vindent = case verbosity cfg of
		Silent -> id
		_ -> indent
	let showPkgSet set = mapM_ (\pkg->echoLn (pkgName pkg++"-"++showVersion (pkgVersion pkg))) (Set.elems set)
	vindent $ showPkgSet diff
	
hpmain :: HPAction ()
hpmain = do
	mode <- loadConfig
	case mode of
		ShowHelp -> liftIO hackageUsage
		ListAll -> listAll
		Query pkg -> query pkg
		Merge pkg -> merge pkg
		DiffTree mode -> diff mode
		Update -> update
		OverlayOnly portdir -> overlayonly portdir

main :: IO ()
main = performHPAction hpmain

{-instance Ord PackageIdentifier where
	compare pkg1 pkg2 = case compare (pkgName pkg1) (pkgName pkg2) of
		EQ -> compare (pkgVersion pkg1) (pkgVersion pkg2)
		x -> x-}
