module Index where

import Data.List(isSuffixOf)
import Data.Maybe(mapMaybe)
import Codec.Compression.GZip(decompress)
import Data.ByteString.Lazy.Char8(ByteString,unpack)
import Codec.Archive.Tar
import Distribution.PackageDescription
import System.FilePath.Posix

type Index = [(String,String,PackageDescription)]

readIndex :: ByteString -> Index
readIndex str = let
	unziped = decompress str
	untared = readTarArchive unziped
	in mapMaybe (\entr -> case splitDirectories (tarFileName (entryHeader entr)) of
		[".",pkgname,vers,file] -> Just (pkgname,vers,
			case parseDescription (unpack (entryData entr)) of
				ParseOk _ descr -> descr
				_ -> error $ "Couldn't read cabal file "++show file)
		_ -> Nothing) (archiveEntries untared)

searchIndex :: (String -> String -> Bool) -> Index -> [PackageDescription]
searchIndex f ind = mapMaybe (\(name,vers,pd) -> if f name vers
	then Just pd
	else Nothing
	) ind
