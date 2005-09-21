module Query where

import Verbosity
import Error

import Control.Exception
import Network.Hackage.Client
import Distribution.Package
import Data.Version
import Data.List (nub,find)
import Text.ParserCombinators.ReadP

parseVersion' :: String -> Maybe Version
parseVersion' str = maybe Nothing (\x->Just (fst x)) (find (\(_,rest)->null rest) (parser str)) where
	parser = readP_to_S parseVersion

getPackageVersions :: Verbosity -> String -> String -> IO [Version]
getPackageVersions verb server name = do
	pkgs <- listPackages server `sayDebug` ("Getting package list from '"++server++"'... ",const "done.\n")
	let foundpkgs = filter (\(pkg,_,_,_)->pkgName pkg == name) pkgs
	case foundpkgs of
		[] -> throwDyn (PackageNotFound name)
		_ -> return $ map (\(pkg,_,_,_)->pkgVersion pkg) foundpkgs
	where
	sayDebug = verboseDebug verb

getPackages :: Verbosity -> String -> IO [String]
getPackages verb server = do
	pkgs <- listPackages server
		`sayDebug` ("Getting package list from '"++server++"'... ",const "done.\n")
	return $ nub $ map (\(pkg,_,_,_)->pkgName pkg) pkgs
	where
	sayDebug = verboseDebug verb
