module Cache where

import MaybeRead
import Error
import Action
import Config
import Portage

import Text.XML.HaXml.Haskell2Xml
import Text.XML.HaXml.Pretty
import Text.XML.HaXml.Types
import Text.XML.HaXml.Parse
import Distribution.Package
import Data.Version
import Network.Hackage.Client
import System.Directory
import System.IO
import Control.Exception
import Control.Monad.Error
import Prelude hiding(catch)

thisVersion=Version { versionBranch=[0,1],versionTags=[] }

data Cache = Cache
	{ serverName::String
	, packages::[(PackageIdentifier,String,String)]
	}

getCacheFromServer :: String -> IO Cache
getCacheFromServer serv = do
	pkgs <- listPackages serv
	return $ Cache
		{ serverName=serv
		, packages=map (\(pkg,_,loc,sig)->(pkg,loc,sig)) pkgs
		}

writeCache :: FilePath -> Cache -> IO ()
writeCache path cache = writeFile path (show (document (cacheToXML cache)))

updateCache :: HPAction Cache
updateCache = do
	cfg <- getCfg
	portTree <- getPortageTree
	cache <- liftIO (getCacheFromServer (server cfg))
		`sayNormal` ("Getting package list from '"++(server cfg)++"'... ",const "done.")
	let writeT = portTree++"/.hackagecache.xml"
	liftIO (writeCache writeT cache)
		`sayDebug` ("Writing cache to '"++writeT++"'... ",const "done.")
	return cache

readCache :: FilePath -> HPAction Cache
readCache path = do
	exist <- liftIO (doesFileExist path)
	case exist of
	  True -> do
	    xmlE <- liftM (xmlParse' path) (liftIO $ readFile path)
				`catchError` const (throwError InvalidCache)
	    let docE = xmlE >>= maybe (fail "") return . cacheFromXML
	    either (const $ throwError InvalidCache) return docE
	  False -> do
	    info "No cache found in overlay, performing update..."
	    updateCache 

cacheToXML :: Cache -> Document
cacheToXML cache = Document prolog emptyST mainElement [] where
	prolog = Prolog Nothing [Comment "This file provides cached information for HackPort.\nYou can update this file by using 'hackport update'."] Nothing []
	mainElement = Elem "cache" [("server",AttValue [Left $ serverName cache]),("version",AttValue [Left $ showVersion thisVersion])] (map ((CElem).packageToXML) (packages cache))

packageToXML :: (PackageIdentifier,String,String) -> Element
packageToXML (pkg,loc,sig) = Elem "package" [("name",AttValue [Left $ pkgName pkg]),("version",AttValue [Left $ showVersion $ pkgVersion pkg]),("location",AttValue [Left loc]),("signature",AttValue [Left sig])] []

packageFromXML :: Content -> Maybe (PackageIdentifier,String,String)
packageFromXML (CElem (Elem name attrs _)) = case name of
	"package" -> do
		pkgname <- lookup "name" attrs
		pkgversion <- lookup "version" attrs
		location <- lookup "location" attrs
		signature <- lookup "signature" attrs
		rpkgname <- case pkgname of
			AttValue [Left n] -> return n
			_ -> Nothing
		rpkgversion <- case pkgversion of
			AttValue [Left n] -> readPMaybe parseVersion n
			_ -> Nothing
		rloc <- case location of
			AttValue [Left n] -> return n
			_ -> Nothing
		rsig <- case signature of
			AttValue [Left n] -> return n
			_ -> Nothing
		return (PackageIdentifier { pkgName=rpkgname, pkgVersion=rpkgversion },rloc,rsig)
	_ -> Nothing
packageFromXML _ = Nothing

cacheFromXML :: Document -> HPAction Cache
cacheFromXML (Document _ _ mainElement []) = do
	case mainElement of
		Elem "cache" attrs cont -> case (do
			version <- lookup "version" attrs
			case version of
				AttValue [Left n] -> readPMaybe parseVersion n
				_ -> Nothing) of
				Nothing -> throwError InvalidCache
				Just vers ->if vers==thisVersion then maybe (throwError InvalidCache) return (do
					ser <- case lookup "server" attrs of
						Just (AttValue [Left n]) -> return n
						_ -> Nothing
					pkgs <- mapM packageFromXML cont
					return (Cache {serverName=ser,packages=pkgs}))
					else throwError WrongCacheVersion
		_ -> throwError InvalidCache
