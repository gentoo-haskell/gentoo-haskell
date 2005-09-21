{-# OPTIONS -fglasgow-exts #-}
module Error where

import Data.Typeable
import Distribution.Package

data HackPortError
	= ConnectionFailed String
	| PackageNotFound
	| InvalidTarballURL String String
	| InvalidSignatureURL String String
	| VerificationFailed String String
	| DownloadFailed String String
	| UnknownCompression String
	| UnpackingFailed String Int
	| NoCabalFound String
	| ExtractionFailed String String Int
	| CabalParseFailed String String
	| BashNotFound
	| BashError String
	| NoOverlay
	| MultipleOverlays [String]
	deriving (Typeable)

type HackPortResult a = Either

hackPortShowError :: String -> Maybe PackageIdentifier -> HackPortError -> String
hackPortShowError server package err = case err of
	ConnectionFailed reason -> "Connection to hackage server '"++server++"' failed: "++reason
	PackageNotFound -> "Package '"++(maybe "" show package)++"' not found on server"
	InvalidTarballURL url reason -> "Error while downloading tarball '"++url++"': "++reason
	InvalidSignatureURL url reason -> "Error while downloading signature '"++url++"': "++reason
	VerificationFailed file signature -> "Error while checking signature('"++signature++"') of '"++file++"'"
	DownloadFailed url reason -> "Error while downloading '"++url++"': "++reason
	UnknownCompression tarball -> "Couldn't guess compression type of '"++tarball++"'"
	UnpackingFailed tarball code -> "Unpacking '"++tarball++"' failed with exit code '"++show code++"'"
	NoCabalFound tarball -> "Tarball '"++tarball++"' doesn't contain a cabal file"
	ExtractionFailed tarball file code -> "Extracting '"++file++"' from '"++tarball++"' failed with '"++show code++"'"
	CabalParseFailed file reason -> "Error while parsing cabal file '"++file++"': "++reason
	BashNotFound -> "The 'bash' executable was not found. It is required to figure out your portage-overlay. If you don't want to install bash, use '-p path-to-overlay'"
	BashError str -> "Error while guessing your portage-overlay. Either set PORTDIR_OVERLAY in /etc/make.conf or use '-p path-to-overlay'.\nThe error was: \""++str++"\""
	MultipleOverlays overlays -> "You have the following overlays available: '"++unwords overlays++"'. Please choose one by using '-p path-to-overlay'"
	NoOverlay -> "You don't have PORTDIR_OVERLAY set in '/etc/make.conf'. Please set it or use '-p path-to-overlay'"
