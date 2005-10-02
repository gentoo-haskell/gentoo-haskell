module TarUtils
	(TarType(..)
	,tarballGetType
	,tarballGetFiles
	,findCabal
	,tarballExtractFile
	) where

import Error
import Action
import Config

import Control.Monad.Trans
import Control.Monad.Error
import System.Process (runInteractiveProcess, waitForProcess)
import System.IO (hClose, hGetContents)
import Text.Printf (printf)
import System.Exit (ExitCode(..))
import Text.Regex (Regex, mkRegex, matchRegex)

data TarType
	= GZip
	| BZip
	| Compress

instance Show TarType where
	show GZip = "--gzip"
	show BZip = "--bzip2"
	show Compress = "--compress"

gzipRegex :: Regex
gzipRegex = mkRegex "^.*?\\.tar\\.gz$|^.*?\\.tgz$"

bzipRegex :: Regex
bzipRegex = mkRegex "^.*?\\.tar\\.bz2$|^.*?\\.tbz2$"

cabalRegex :: Regex
cabalRegex = mkRegex "^(.*?)/([^/]*?\\.cabal)$"

tarballGetType :: FilePath -> Maybe TarType
tarballGetType path
	| maybe False (const True) (matchRegex gzipRegex path) = Just GZip
	| maybe False (const True) (matchRegex bzipRegex path) = Just BZip
	| otherwise = Nothing

tarballGetFiles :: FilePath 
		-> FilePath
		-> TarType
		-> HPAction [FilePath]
tarballGetFiles tarCommand tarball tartype = do
	(inch,outch,_,handle) <- liftIO $ runInteractiveProcess tarCommand args Nothing Nothing
	liftIO $ hClose inch
	files <- liftIO $ hGetContents outch
	length files `seq` liftIO $ hClose outch
	exitCode <- liftIO $ waitForProcess handle
	case exitCode of
		ExitFailure err -> throwError $ UnpackingFailed tarball err
		ExitSuccess -> return (lines files)
	where
	args = ["--list"
	       ,show tartype
               ,"--file"
	       ,tarball]

findCabal :: [FilePath] -> Maybe (FilePath,FilePath) --Finds the path where a .cabal file is and the name
findCabal (x:xs) = case matchRegex cabalRegex x of
	Just (loc:name:[]) -> Just (loc,name)
	Nothing -> findCabal xs
findCabal [] = Nothing

tarballExtractFile ::
                   FilePath -- the archive
                   -> TarType  -- the type of the archive
                   -> FilePath -- the file
                   -> HPAction String
tarballExtractFile tarball tarType file = do
	cfg <- getCfg
	(inch,outch,_,handle) <- liftIO $ runInteractiveProcess (tarCommand cfg) args Nothing Nothing
	liftIO $ hClose inch
	res <- liftIO $ hGetContents outch
	length res `seq` liftIO $ hClose outch
	exitCode <- liftIO $ waitForProcess handle
	case exitCode of
		ExitFailure err -> throwError $ ExtractionFailed file tarball err
		ExitSuccess -> return res
	where
	args = ["--to-stdout"
	       ,show tarType
	       ,"--file"
	       ,tarball
	       ,"--get"
	       ,file]

