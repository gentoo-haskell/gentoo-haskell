module GenerateEbuild where

import Cabal2Ebuild
import Fetch
import TarUtils
import Error
import Verbosity

import Prelude hiding (catch)
import Control.Exception
import Network.Hackage.Client as Hackage
import Distribution.PackageDescription
import Distribution.Package
import System.Directory

mergeEbuild :: Verbosity -> FilePath -> String -> EBuild -> IO ()
mergeEbuild verb target category ebuild = do
	let edir = target++"/"++category++"/"++(name ebuild)
	let epath = edir++"/"++(name ebuild)++"-"++(version ebuild)++".ebuild"
	createDirectoryIfMissing True edir
		`sayDebug` ("Creating '"++edir++"'... ",const "done.\n")
	writeFile epath (showEBuild ebuild)
		`sayNormal` ("Merging to '"++epath++"'... ",const "done.\n")
	where
	sayNormal = verboseNormal verb
	sayDebug = verboseDebug verb

hackage2ebuild ::
	Verbosity ->		-- ^ verbosity level
	FilePath ->		-- ^ the tar executable
	String ->		-- ^ the hackage server
	FilePath ->		-- ^ a temp path to store the tarball
	Bool ->			-- ^ gpg verify the package?
	PackageIdentifier ->	-- ^ the package
	IO EBuild
hackage2ebuild verb tarCommand server store verify pkg = do
	resolvedPackage <- Hackage.getPkgLocation server pkg
		`sayDebug` ("Getting package location from '"++server++"'... ",maybe "\n" (\(tar,sig)->"Found tarball '"++tar++"' and signature '"++sig++"'\n"))
		`catch` (\x->throwDyn $ ConnectionFailed (show x))
	(tarball,sig) <- maybe (throwDyn (PackageNotFound (Right pkg))) return resolvedPackage
	tarballPath <- (if verify then (do
		(tarPath,sigPath) <- downloadFileVerify store tarball sig
		removeFile sigPath
		return tarPath) else downloadTarball store tarball)
		`sayDebug` ("Downloading tarball to '"++store++"'... ",const "done.\n")
	tarType <- maybe (removeFile tarballPath >> throwDyn (UnknownCompression tarball)) return (tarballGetType tarballPath)
		`sayDebug` ("Guessing compression type of tarball... ",const "done.\n")
	filesInTarball <- tarballGetFiles tarCommand tarballPath tarType
		`sayDebug` ("Getting list of files from tarball... ",const "done.\n")
		`catch` (\x->removeFile tarballPath >> throw x)
	(cabalDir,cabalName) <- maybe (throwDyn $ NoCabalFound tarball) return (findCabal filesInTarball)
		`sayDebug` ("Trying to find cabal file... ",\(dir,name)->"Found cabal file '"++name++"' in '"++dir++"'.\n")
	cabalFile <- tarballExtractFile tarCommand tarballPath tarType (cabalDir++"/"++cabalName)
		`sayDebug` ("Extracting cabal file... ",const "done.\n")
	packageDescription <- case parseDescription cabalFile of
		ParseFailed err -> throwDyn $ CabalParseFailed cabalName (showError err)
		ParseOk descr -> return descr
		`sayDebug` ("Parsing '"++cabalName++"'... ",const "done.\n")
	let ebuild=cabal2ebuild (packageDescription{pkgUrl=tarball}) --we don't trust the cabal file as we just successfully downloaded the tarbal somewhere
	return ebuild {cabalPath=Just cabalDir}
	where
	sayNormal = verboseNormal verb
	sayDebug = verboseDebug verb
