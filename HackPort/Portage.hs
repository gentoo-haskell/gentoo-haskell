module Portage where

import Distribution.Package
import System.Directory
import Text.Regex
import Data.Maybe
import Data.Version
import MaybeRead


ebuildVersionRegex name = mkRegex ("^"++name++"\\-(.*?)\\.ebuild$")

portageGetPackages ::
	String ->	-- ^ the portage dir
	String ->	-- ^ the category
	IO [PackageIdentifier]
portageGetPackages portTree category
	= do
		let basedir=portTree++"/"++category++"/"
		content <- getDirectoryContents basedir
		pkgs <- filterPackages basedir content
		identifiers <- mapM (\pkgname->
			(portageGetPackageVersions portTree category pkgname
				>>=(\pkgversions->return (map (\pkgv->PackageIdentifier{pkgName=pkgname,pkgVersion=pkgv}) pkgversions)))
			) pkgs
		return $ concat identifiers

portageGetPackageVersions ::
	String ->	-- ^ the portage dir
	String ->	-- ^ the category
	String ->	-- ^ the package
	IO [Version]
portageGetPackageVersions portTree category name
	= do
		let basedir=portTree++"/"++category++"/"++name++"/"
		content <- getDirectoryContents basedir
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
