module Query where

import Network.Hackage.Client
import Distribution.Package
import Data.Version
import Data.List (nub,find)
import Text.ParserCombinators.ReadP

parseVersion' :: String -> Maybe Version
parseVersion' str = maybe Nothing (\x->Just (fst x)) (find (\(_,rest)->null rest) (parser str)) where
	parser = readP_to_S parseVersion

getPackageVersions :: String -> String -> IO [Version]
getPackageVersions server name = do
	pkgs <- listPackages server
	let foundpkgs = filter (\(pkg,_,_,_)->pkgName pkg == name) pkgs
	return $ map (\(pkg,_,_,_)->pkgVersion pkg) foundpkgs

getPackages :: String -> IO [String]
getPackages server = do
	pkgs <- listPackages server
	return $ nub $ map (\(pkg,_,_,_)->pkgName pkg) pkgs
