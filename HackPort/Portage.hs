module Portage where

import Control.Monad.Trans
import Distribution.Package
import System.Directory
import Text.Regex
import Data.Maybe
import Data.Version

import Bash
import MaybeRead
import Action
import Config

ebuildVersionRegex name = mkRegex ("^"++name++"\\-(.*?)\\.ebuild$")

portageGetPackages ::
	String ->	-- ^ the portage dir
	HPAction [PackageIdentifier]
portageGetPackages portTree = do
	cfg <- getCfg
	let basedir=portTree++"/"++(portageCategory cfg)++"/"
	content <- liftIO $ getDirectoryContents basedir
	pkgs <- liftIO $ filterPackages basedir content
	identifiers <- mapM (\pkgname->
		(portageGetPackageVersions portTree pkgname
			>>=(\pkgversions->return (map (\pkgv->PackageIdentifier{pkgName=pkgname,pkgVersion=pkgv}) pkgversions)))
		) pkgs
	return $ concat identifiers

portageGetPackageVersions ::
	String ->	-- ^ the portage dir
	String ->	-- ^ the package
	HPAction [Version]
portageGetPackageVersions portTree name
	= do
		cfg <- getCfg
		let basedir=portTree++"/"++(portageCategory cfg)++"/"++name++"/"
		content <- liftIO $ getDirectoryContents basedir
		let versions=map head (mapMaybe (matchRegex (ebuildVersionRegex name)) content)
		return (mapMaybe (readPMaybe parseVersion) versions)

filterPackages :: String -> [String] -> IO [String]
filterPackages _ [] = return []
filterPackages base (x:xs) = do
	ak <- case x of
		"." -> return Nothing
		".." -> return Nothing
		dir -> do
			exists <- doesDirectoryExist (base++dir)
			return (if exists then Just dir else Nothing)
	rest <- filterPackages base xs
	return (maybe rest (:rest) ak)

{-filterVersions :: String -> [String] -> IO [String]
filterVersions _ [] = return []
filterVersions base (x:xs) = do
	ak <- case x of
		"." -> return Nothing
		".." -> return Nothing
		dir -> do
			exists <- doesFileExist (base++dir)
			return (if exists then Just dir else Nothing)
	rest <- filterVersions base xs
	return (maybe rest (:rest) ak)
-}

--diffPackageLists :: [PackageIdentifier] -> [PackageIdentifier] -> String
--diffPackageLists 


getPortageTree :: HPAction String
getPortageTree = do
	cfg <- getCfg
	case portageTree cfg of
		Nothing -> do
		  tree <- getOverlay `sayDebug` ("Guessing overlay from /etc/make.conf...\n",\tree->"Found '"++tree++"'")
		  setPortageTree $ Just tree
		  return tree
		Just tree -> return tree


