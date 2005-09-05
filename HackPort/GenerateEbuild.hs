module GenerateEbuild where

import Cabal2Ebuild
import Fetch
import TarUtils
import Network.Hackage.Client as Hackage
import Distribution.PackageDescription
import Distribution.Package
import System.Directory

mergeEbuild :: FilePath -> String -> EBuild -> IO ()
mergeEbuild target category ebuild = do
	let epath = target++"/"++category++"/"++(name ebuild)
	createDirectoryIfMissing True epath
	writeFile (epath++"/"++(name ebuild)++"-"++(version ebuild)++".ebuild") (showEBuild ebuild)

hackage2ebuild :: String -> FilePath -> PackageIdentifier -> IO (Either String EBuild)
--                |         |           \the package
--                |         \a temp path to store the tarball
--                \the server
--                 
hackage2ebuild server store pkg = do
	result <- Hackage.getPkgLocation server pkg
	case result of
		Nothing -> return (Left "Package not found on Hackage Server")
		Just (tarball,sig) -> do
			downloadres <- downloadFile store tarball
			case downloadres of
				Left err -> return (Left (show err))
				Right tarballloc -> do
					case tarballGetType tarball of
						Nothing -> return $ Left "Couldn't guess compression type of tarball"
						Just tarType -> do
							files <- tarballGetFiles "/bin/tar" tarballloc tarType
							case findCabal files of
								Nothing -> return $ Left "No cabal file found in tarball"
								Just (caballoc,cabalname) -> do
									cabalfile <- tarballExtractFile "/bin/tar" tarballloc tarType (caballoc++"/"++cabalname)
									case parseDescription cabalfile of
										ParseFailed err -> return $ Left ("Parsing '"++cabalname++"' failed: "++(showError err))
										ParseOk descr -> return $ Right ((cabal2ebuild descr) {src_uri=tarball,cabalPath=Just caballoc})
