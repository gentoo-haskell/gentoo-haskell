module GenerateEbuild where

import Action
import Cabal2Ebuild
--import Fetch
--import TarUtils
import Config
import Error

import Prelude hiding (catch)
import Control.Monad.Trans
import Control.Monad.Error
import Control.Exception
import Distribution.PackageDescription
import Distribution.Package
import Data.Version (showVersion)
import Network.URI
import System.Directory
import System.FilePath

mergeEbuild :: FilePath -> EBuild -> HPAction ()
mergeEbuild target ebuild = do
	cfg <- getCfg
	let edir = target </> portageCategory cfg </> name ebuild
	let epath = edir </> name ebuild ++"-"++ version ebuild <.> "ebuild"
	liftIO (createDirectoryIfMissing True edir)
		`sayDebug` ("Creating '"++edir++"'... ",const "done.")
	liftIO (writeFile epath (showEBuild ebuild))
		`sayNormal` ("Merging to '"++epath++"'... ",const "done.")

fixSrc :: PackageIdentifier -> EBuild -> HPAction EBuild
fixSrc p ebuild | null (src_uri ebuild) = do
	cfg <- getCfg
	return $ ebuild {
		src_uri = show $ (server cfg) {
			uriPath = (uriPath (server cfg))
				</> pkgName p
				</> showVersion (pkgVersion p)
				</> pkgName p ++ "-" ++
					showVersion (pkgVersion p)
				<.> "tar.gz"
			}
		}
		| otherwise = return ebuild

{-hackage2ebuild ::
	(PackageIdentifier,String,String) ->	-- ^ the package
	HPAction EBuild
hackage2ebuild (pkg,tarball,sig) = do
	cfg <- getCfg
	tarballPath <- (if verify cfg then (do
		(tarPath,sigPath) <- downloadFileVerify (tmp cfg) tarball sig
		liftIO $ removeFile sigPath
		return tarPath) else (downloadTarball (tmp cfg) tarball))
		`sayNormal` ("Downloading tarball from '"++tarball++"' to '"++(tmp cfg)++"'... ",const "done.")
	tarType <- maybe (liftIO (removeFile tarballPath) >> throwError (UnknownCompression tarball)) return (tarballGetType tarballPath)
		`sayDebug` ("Guessing compression type of tarball... ",const "done.")
	filesInTarball <- tarballGetFiles (tarCommand cfg) tarballPath tarType
		`sayDebug` ("Getting list of files from tarball... ",const "done.")
		`catchError` (\x->liftIO (removeFile tarballPath) >> throwError x)
	(cabalDir,cabalName) <- maybe (throwError $ NoCabalFound tarball) return (findCabal filesInTarball)
		`sayDebug` ("Trying to find cabal file... ",\(dir,name)->"Found cabal file '"++name++"' in '"++dir++"'.")
	cabalFile <- tarballExtractFile tarballPath tarType (cabalDir++"/"++cabalName)
		`sayDebug` ("Extracting cabal file... ",const "done.")
	packageDescription <- case parseDescription cabalFile of
		ParseFailed err -> throwError $ CabalParseFailed cabalName (showError err)
		ParseOk descr -> return descr
		`sayDebug` ("Parsing '"++cabalName++"'... ",const "done.")
	let ebuild=cabal2ebuild (packageDescription{pkgUrl=tarball}) --we don't trust the cabal file as we just successfully downloaded the tarbal somewhere
	return ebuild {cabalPath=Just cabalDir}-}
