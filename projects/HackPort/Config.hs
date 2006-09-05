module Config where

import System.Console.GetOpt
import Control.Exception
import Text.Regex
import Distribution.Package

import Error
import MaybeRead

data HackPortOptions
	= TarCommand String
	| PortageTree String
	| Category String
	| Server String
	| TempDir String
	| Verify
	| Verbosity String

data OperationMode
	= Query String
	| Merge PackageIdentifier
	| ListAll
	| DiffTree DiffMode
	| Update
	| ShowHelp
	| OverlayOnly (Maybe String)

data DiffMode
	= ShowAll
	| ShowMissing
	| ShowAdditions
	| ShowCommon
	deriving Eq

data Config = Config
	{ tarCommand		::String
	, portageTree		::Maybe String
	, portageCategory	::String
	, server		::String
	, tmp			::String
	, verify		::Bool
	, verbosity		::Verbosity
	}

data Verbosity
	= Debug
	| Normal
	| Silent

packageRegex = mkRegex "^(.*?)-([0-9].*)$"

defaultConfig :: Config
defaultConfig = Config
	{ tarCommand = "/bin/tar"
	, portageTree = Nothing
	, portageCategory = "dev-haskell"
	, server = "http://hackage.haskell.org/ModHackage/Hackage.hs?action=xmlrpc"
	, tmp = "/tmp"
	, verify = False
	, verbosity = Normal
	}

hackageOptions :: [OptDescr HackPortOptions]
hackageOptions = [Option ['p'] ["portage-tree"] (ReqArg PortageTree "PATH") "The portage tree to merge to"
	  ,Option ['c'] ["portage-category"] (ReqArg Category "CATEGORY") "The cateory the program belongs to"
	  ,Option ['s'] ["server"] (ReqArg Server "URL") "The Hackage server to query"
	  ,Option ['t'] ["temp-dir"] (ReqArg TempDir "PATH") "A temp directory where tarballs can be stored"
          ,Option [] ["tar"] (ReqArg TarCommand "PATH") "Path to the \"tar\" executable"
	  ,Option [] ["verify"] (NoArg Verify) "Verify downloaded tarballs using GnuPG"
	  ,Option ['v'] ["verbosity"] (ReqArg Verbosity "debug|normal|silent") "Set verbosity level(default is 'normal')"
	  ]

parseConfig :: [String] -> Either String ([HackPortOptions],OperationMode)
parseConfig opts = let
	(popts,args,errs) = getOpt Permute hackageOptions opts
	mode = if not (null errs) then Left ("Error while parsing flags:\n"++concat errs) else case args of
		"query":[] -> Left "Need a package name to query.\n"
		"query":package:[] -> Right (Query package)
		"query":package:rest -> Left ("'query' takes one argument("++show ((length rest)+1)++" given).\n")
		"merge":[] -> Left "Need a package's name and version to merge it.\n"
		"merge":package:[] -> case readPMaybe parsePackageId package of
			Nothing ->Left ("Could not parse '"++package++"' to a valid package. Valid packages use <name>-<version-number>-<version-postfix> where version consists only of numbers and points.\n")
			Just pid -> Right (Merge pid)
		"merge":_:rest -> Left ("'merge' takes 1 argument("++show ((length rest)+1)++" given).\n")
		"list":[] -> Right ListAll
		"list":rest -> Left ("'list' takes zero arguments("++show (length rest)++" given).\n")
		"diff":[] -> Right (DiffTree ShowAll)
		"diff":"all":[] -> Right (DiffTree ShowAll)
		"diff":"missing":[] -> Right (DiffTree ShowMissing)
		"diff":"additions":[] -> Right (DiffTree ShowAdditions)
		"diff":"common":[] -> Right (DiffTree ShowCommon)
		"diff":arg:[] -> Left ("Unknown argument to 'diff': Use all,missing,additions or common.\n")
		"diff":arg1:args -> Left ("'diff' takes one argument("++show ((length args)+1)++" given).\n")
		"update":[] -> Right Update
		"update":rest -> Left ("'update' takes zero arguments("++show (length rest)++" given).\n")
		"overlayonly":[] -> Right (OverlayOnly Nothing)
		"overlayonly":portdir:[] -> Right (OverlayOnly (Just portdir))
		"overlayonly":arg:args -> Left ("'overlayonly' takes only one argument("++show ((length args)+1)++" given).\n")
		[] -> Right ShowHelp
		_ -> Left "Unknown opertation mode\n"
	in case mode of
		Left err -> Left err
		Right mod -> Right (popts,mod)

hackageUsage :: IO ()
hackageUsage = putStr $ flip usageInfo hackageOptions $ unlines
	[ "Usage:"
	, "\t\"hackport [OPTION] MODE [MODETARGET]\""
	, "\t\"hackport [OPTION] list\" prints all available packages"
	, "\t\"hackport [OPTION] query PKG\" prints all versions of a package"
	, "\t\"hackport [OPTION] merge PKG-VERSION\" merges a package into the portage tree"
	, "\t\"hackport [OPTION] diff\" prints the difference between the portage-tree and the server's packages"
	, "\t\"hackport [OPTION] update\" updates the local cache"
	, "\t\"hackport [OPTION] overlayonly\" prints all ebuilds that exist only in the overlay"
	, "Options:"
	]

parseVerbosity :: String -> Maybe Verbosity
parseVerbosity "debug" = Just Debug
parseVerbosity "normal" = Just Normal
parseVerbosity "silent" = Just Silent
parseVerbosity _ = Nothing

