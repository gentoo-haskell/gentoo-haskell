module GenerateEbuild where

import Cabal2Ebuild
import Fetch
import TarUtils
import Error

import Prelude hiding (catch)
import Control.Exception
import Network.Hackage.Client as Hackage
import Distribution.PackageDescription
import Distribution.Package
import System.Directory

mergeEbuild :: FilePath -> String -> EBuild -> IO ()
mergeEbuild target category ebuild = do
	let epath = target++"/"++category++"/"++(name ebuild)
	createDirectoryIfMissing True epath
	writeFile (epath++"/"++(name ebuild)++"-"++(version ebuild)++".ebuild") (showEBuild ebuild)

hackage2ebuild :: 
	FilePath ->		-- ^ the tar executable
	String ->		-- ^ the hackage server
	FilePath ->		-- ^ a temp path to store the tarball
	Bool ->			-- ^ gpg verify the package?
	PackageIdentifier ->	-- ^ the package
	IO EBuild
hackage2ebuild tarCommand server store verify pkg = do
	resolvedPackage <- Hackage.getPkgLocation server pkg `catch` (\x->throwDyn $ ConnectionFailed (show x))
	(tarball,sig) <- maybe (throwDyn PackageNotFound) return resolvedPackage
	tarballPath <- if verify then (do
		(tarPath,sigPath) <- downloadFileVerify store tarball sig
		removeFile sigPath
		return tarPath) else downloadTarball store tarball
	tarType <- maybe (removeFile tarballPath >> throwDyn (UnknownCompression tarball)) return (tarballGetType tarballPath)
	filesInTarball <- tarballGetFiles tarCommand tarballPath tarType `catch` (\x->removeFile tarballPath >> throw x)
	(cabalDir,cabalName) <- maybe (throwDyn $ NoCabalFound tarball) return (findCabal filesInTarball)
	cabalFile <- tarballExtractFile tarCommand tarballPath tarType (cabalDir++"/"++cabalName)
	packageDescription <- case parseDescription cabalFile of
		ParseFailed err -> throwDyn $ CabalParseFailed cabalName (showError err)
		ParseOk descr -> return descr
	let ebuild=cabal2ebuild (packageDescription{pkgUrl=tarball}) --we don't trust the cabal file as we just successfully downloaded the tarbal somewhere
	return $ ebuild {cabalPath=Just cabalDir}
