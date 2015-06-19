{-# OPTIONS -w -funbox-strict-fields #-}
module Options(
    processOptions,
    Opt(..),
    options,
    Mode(..),
    StopCondition(..),
    putVerbose,
    putVerboseLn,
    putProgress,
    putProgressLn,
    getArguments,
    findHoCache,
    verbose,
    verbose2,
    progress,
    dump,
    wdump,
    fopts,
    flint,
    fileOptions,
    withOptions,
    withOptionsT,
    getArgString,
    outputName,
    OptM(),
    OptT(),
    OptionMonad(..),
    flagOpt
    ) where

import Control.Monad.Error()    -- IO MonadPlus instance
import Control.Monad.Identity
import Control.Monad.Reader
import Data.List(nub)
import Data.Maybe
import System
import System.Console.GetOpt
import System.Directory
import System.IO.Unsafe
import qualified Data.ByteString.UTF8 as BS
import qualified Data.Map as M
import qualified Data.Set as S

import RawFiles(targets_ini)
import Support.IniParse
import Support.TempDir
import Util.ExitCodes
import Util.Gen
import Util.YAML
import Version.Config
import Version.Version(versionString,versionContext)
import qualified FlagDump
import qualified FlagOpts
import qualified Version.Config as VC

{-@CrossCompilation

# Basics

Unlike many other compilers, jhc is a native cross compiler. What this means is
that every compile of jhc is able to create code for all possible target
systems. This leads to many simplifications when it comes to cross compiling
with jhc. Basically in order to cross compile, you need only pass the flag
'--cross' to jhc, and pass an appropriate '-m' option to tell jhc what machine
you are targetting. An example would be

    ; jhc --cross -mwin32 test/HelloWorld.hs

The targets list is extensible at run-time via the targets.ini file explained
below.

# targets.ini

This file determines what targets are available. The format consists of entries as follows.

    [targetname]
    key1=value
    key2=value
    key3+=value
    merge=targetname2

merge is a special key meaning to merge the contents of another target into the
current one. The configuration file is read in order, and the final value set
for a given key is the one that is used.

An example describing how to cross compile for windows is as follows:

    [win32]
    cc=i386-mingw32-gcc
    cflags+=-mwindows -mno-cygwin
    executable_extension=.exe
    merge=i686

This sets the compiler to use as well as a few other options then jumps to the
generic i686 routine. The special target [default] is always read before all
other targets. If '--cross' is specified on the command line then this is the
only implicitly included configuration, otherwise jhc will assume you are
compiling for the current architecture and choose an appropriate target to
include in addition to default.

jhc will attempt to read several targets.ini files in order. they are

$PREFIX/etc/jhc-\$VERSION/targets.ini
: this is the targets.ini that is included with jhc and contains the default options.

$PREFIX/etc/jhc-\$VERSION/targets-local.ini
: jhc will read this if it exists, it is used to specify custom system wide configuration options, such as the name of local compilers.

$HOME/.jhc/targets.ini
: this is where a users local configuration information goes.

$HOME/etc/jhc/targets.ini
: this is simply for people that prefer to not use hidden directories for configuration

The last value specified for an option is the one used, so a users local
configuration overrides the system local version which overrides the built in
options.

# Options available

Option                    Meaning
------                    ---------------------------------------------------------------------------
_cc_                      what c compiler to use. generally this will be gcc for local builds and something like $ARCH-$HOST-gcc for cross compiles
_byteorder_               one of *le* or *be* for little or big endian
_gc_                      what garbage collector to use. It should be one of *static* or *boehm*.
_cflags_                  options to pass to the c compiler
_cflags\_debug_           options to pass to the c compiler only when debugging is enabled
_cflags\_nodebug_         options to pass to the c compiler only when debugging is disabled
_profile_                 whether to include profiling code in the generated executable
_autoload_                what haskell libraries to autoload, seperated by commas.
_executable\_extension_   specifies an extension that should be appended to executable files, (i.e. .EXE on windows)
_merge_                   a special option that merges the contents of another configuration target into the currrent one.
_bits_                    the number of bits a pointer contains on this architecture
_bits\_max_               the number of bits in the largest integral type. should be the number of bits in the 'intmax_t' C type.
_arch_                    what to pass to gcc as the architecture

-}

data Mode = BuildHl FilePath         -- ^ Build the specified hl-file given a description file.
          | Interactive              -- ^ Run interactively.
          | Version                  -- ^ Print version and die.
          | VersionCtx               -- ^ Print version context and die.
          | ShowHelp                 -- ^ Show help message and die.
          | ShowConfig               -- ^ Show configuration info.
          | CompileExe               -- ^ Compile executable
          | ShowHo String            -- ^ Show ho-file.
          | ListLibraries            -- ^ List libraries
          | PrintHscOptions          -- ^ Print options for hsc2hs
          | PurgeCache               -- ^ Purge the cache
          | Preprocess               -- ^ Filter through preprocessor
            deriving(Eq)

data StopCondition
    = StopError String         -- ^ error
    | StopParse                -- ^ Just parse and rename modules then exit
    | StopTypeCheck            -- ^ Stop after type checking
    | StopC                    -- ^ Stop after producing C code.
    | CompileHo                -- ^ Compile ho
    | StopNot                  -- ^ Don't stop believing.
            deriving(Eq)

data Opt = Opt {
    optMode        ::  Mode,      -- ^ Mode of interaction
    optColumns     :: !Int,       -- ^ Width of terminal.
    optDump        ::  [String],  -- ^ Dump options (raw).
    optStmts       ::  [String],  -- ^ statements to execute
    optFOpts       ::  [String],  -- ^ Flag options (raw).
    optIncdirs     ::  [String],  -- ^ Include directories.
    optCCargs      ::  [String],  -- ^ Optional arguments to the C compiler.
    optHls         ::  [String],  -- ^ Load the specified hl-files (haskell libraries).
    optAutoLoads   ::  [String],  -- ^ AutoLoaded haskell libraries.
    optHlPath      ::  [String],  -- ^ Path to look for libraries.
    optIncs        ::  [String],
    optDefs        ::  [String],
    optExtensions  ::  [String],
    optStop        ::  StopCondition,
    optWorkDir     ::  Maybe FilePath,
    optAnnotate    ::  Maybe FilePath,
    optDeps        ::  Maybe FilePath,
    optHoDir       ::  Maybe FilePath,
    optHoCache     ::  Maybe FilePath,
    optArgs        ::  [String],
    optStale       ::  [String],  -- ^ treat these modules as stale
    optKeepGoing   :: !Bool,      -- ^ Keep going when encountering errors.
    optMainFunc    ::  Maybe (Bool,String),    -- ^ Entry point name for the main function.
    optArch        ::  [String],           -- ^ target architecture
    optCross       ::  Bool,
    optOutName     ::  Maybe String,           -- ^ Name of output file.
    optIgnoreHo    :: !Bool,                   -- ^ Ignore ho-files.
    optNoWriteHo   :: !Bool,                   -- ^ Don't write ho-files.
    optNoAuto      :: !Bool,                   -- ^ Don't autoload packages
    optVerbose     :: !Int,                    -- ^ Verbosity
    optStatLevel   :: !Int,                    -- ^ Level to print statistics
    optInis        ::  M.Map String String,    -- ^ options read from ini files
    optDumpSet     ::  S.Set FlagDump.Flag,    -- ^ Dump flags.
    optFOptsSet    ::  S.Set FlagOpts.Flag     -- ^ Flag options (-f\<opt\>).
  } {-!derive: update !-}

emptyOpt = Opt {
    optMode        = CompileExe,
    optColumns     = getColumns,
    optCross       = False,
    optIncdirs     = initialIncludes,
    optAnnotate    = Nothing,
    optDeps        = Nothing,
    optHls         = [],
    optAutoLoads   = [],
    optHlPath      = initialLibIncludes,
    optIncs        = [],
    optDefs        = [],
    optExtensions  = [],
    optStop        = StopNot,
    optDump        = [],
    optStale       = [],
    optStmts       = [],
    optFOpts       = ["default"],
    optCCargs      = [],
    optWorkDir     = Nothing,
    optHoDir       = Nothing,
    optHoCache     = Nothing,
    optArgs        = [],
    optIgnoreHo    = False,
    optNoWriteHo   = False,
    optKeepGoing   = False,
    optMainFunc    = Nothing,
    optArch        = ["default"],
    optOutName     = Nothing,
    optVerbose     = 0,
    optStatLevel   = 1,
    optNoAuto      = False,
    optDumpSet     = S.singleton FlagDump.Progress,
    optFOptsSet    = S.empty
}

idu "-" _ = []
idu d ds = ds ++ [d]

theoptions :: [OptDescr (Opt -> Opt)]
theoptions =
    [ Option ['V'] ["version"]         (NoArg  (optMode_s Version))          "print version info and exit"
    , Option []    ["version-context"] (NoArg  (optMode_s VersionCtx))       "print version context info and exit"
    , Option []    ["help"]            (NoArg  (optMode_s ShowHelp))         "print help information and exit"
    , Option []    ["info"]            (NoArg  (optMode_s ShowConfig))       "show compiler configuration information and exit"
    , Option []    ["purge-cache"]     (NoArg  (optMode_s PurgeCache))       "clean out jhc compilation cache"
    , Option ['v'] ["verbose"]         (NoArg  (optVerbose_u (+1)))          "chatty output on stderr"
    , Option ['z'] []                  (NoArg  (optStatLevel_u (+1)))        "Increase verbosity of statistics"
    , Option ['d'] []                  (ReqArg (optDump_u . (:))  "[no-]flag") "dump specified data during compilation"
    , Option ['f'] []                  (ReqArg (optFOpts_u . (:)) "[no-]flag") "set or clear compilation options"
    , Option ['X'] []                  (ReqArg (optExtensions_u . (:))  "ExtensionName") "enable the given language extension"
    , Option ['o'] ["output"]          (ReqArg (optOutName_s . Just) "FILE") "output to FILE"
    , Option ['i'] ["include"]         (ReqArg (optIncdirs_u . idu) "DIR")   "where to look for source files"
    , Option ['I'] []                  (ReqArg (optIncs_u . idu) "DIR")       "add to preprocessor include path"
    , Option ['D'] []                  (ReqArg (optDefs_u . (:)) "NAME=VALUE") "add new definitions to set in preprocessor"
    , Option []    ["optc"]            (ReqArg (optCCargs_u . idu) "option") "extra options to pass to c compiler"
    , Option ['c'] []                  (NoArg  (optStop_s CompileHo))        "just compile the modules, caching the results."
    , Option ['C'] []                  (NoArg  (optStop_s StopC))            "compile to C code"
    , Option ['E'] []                  (NoArg  (optMode_s Preprocess))       "preprocess the input and print result to stdout"
    , Option ['k'] ["keepgoing"]       (NoArg  (optKeepGoing_s True))        "keep going on errors"
    , Option []    ["cross"]           (NoArg  (optCross_s True))            "enable cross-compilation, choose target with the -m flag"
    , Option []    ["stop"]            (ReqArg (optStop_s . stop) "parse/typecheck/c") "stop after the given pass, parse/typecheck/c"
    , Option []    ["width"]           (ReqArg (optColumns_s . read) "COLUMNS") "width of screen for debugging output"
    , Option []    ["main"]            (ReqArg (optMainFunc_s . Just . (,) False) "Main.main")  "main entry point"
    , Option ['m'] ["arch"]            (ReqArg (optArch_u . idu ) "arch")      "target architecture options"
    , Option []    ["entry"]           (ReqArg (optMainFunc_s . Just . (,) True)  "<expr>")  "main entry point, showable expression"
    --    , Option ['e'] []            (ReqArg (\d -> optStmts_u ( d:)) "<statement>")  "run given statement as if on jhci prompt"
    , Option []    ["show-ho"]         (ReqArg (optMode_s . ShowHo) "file.ho") "Show ho file"
    , Option []    ["noauto"]          (NoArg  (optNoAuto_s True))           "Don't automatically load base and haskell98 packages"
    , Option ['p'] []                  (ReqArg (optHls_u . (:)) "package")   "Load given haskell library package"
    , Option ['L'] []                  (ReqArg (optHlPath_u . idu) "path")   "Look for haskell libraries in the given directory"
    , Option []    ["build-hl"]        (ReqArg (optMode_s . BuildHl) "desc.yaml") "Build hakell library from given library description file"
    , Option []    ["annotate-source"] (ReqArg (optAnnotate_s . Just) "<dir>") "Write preprocessed and annotated source code to the directory specified"
    , Option []    ["deps"]            (ReqArg (optDeps_s . Just) "<file.yaml>") "Write dependency information to file specified"
    , Option []    ["interactive"]     (NoArg  (optMode_s Interactive))      "run interactivly                                                             ( for debugging only)"
    , Option []    ["ignore-cache"]    (NoArg  (optIgnoreHo_s True))         "Ignore existing compilation cache entries."
    , Option []    ["readonly-cache"]  (NoArg  (optNoWriteHo_s True))        "Do not write new information to the compilation cache."
    , Option []    ["no-cache"]        (NoArg  (optNoWriteHo_s True . optIgnoreHo_s True)) "Do not use or update the cache."
    , Option []    ["cache-dir"]       (ReqArg (optHoCache_s . Just ) "JHC_CACHE")  "Use a global cache located in the directory passed as an argument."
--    , Option []    ["ho-dir"]          (ReqArg (optHoDir_s . Just ) "<dir>")    "Where to place and look for ho files"
    , Option []    ["stale"]           (ReqArg (optStale_u . idu) "Module")  "Treat these modules as stale, even if they exist in the cache"
    , Option []    ["list-libraries"]  (NoArg  (optMode_s ListLibraries))    "List of installed libraries"
    , Option []    ["tdir"]            (ReqArg (optWorkDir_s . Just) "dir/") "specify the directory where all intermediate files/dumps will be placed."
--    , Option []    ["print-hsc-options"] (NoArg (optMode_s PrintHscOptions)) "print options to pass to hsc2hs"
    ]

stop "parse" = StopParse
stop "deps" = StopParse
stop "typecheck" = StopTypeCheck
stop "c" = StopC
stop s = StopError s

-- | Width of terminal.
getColumns :: Int
getColumns = read $ unsafePerformIO (getEnv "COLUMNS" `mplus` return "80")

postProcessFD :: Monad m => Opt -> m Opt
postProcessFD o = case FlagDump.process (optDumpSet o) (optDump o ++ vv) of
        (s,[]) -> return $ o { optDumpSet = s, optDump = [] }
        (_,xs) -> fail ("Unrecognized dump flag passed to '-d': "
                        ++ unwords xs ++ "\nValid dump flags:\n\n" ++ FlagDump.helpMsg)
    where
    vv | optVerbose o >= 2 = ["veryverbose"]
       | optVerbose o >= 1 = ["verbose"]
       | otherwise = []

postProcessFO :: Monad m => Opt -> m Opt
postProcessFO o = case FlagOpts.process (optFOptsSet o) (optFOpts o) of
        (s,[]) -> return $ o { optFOptsSet = s, optFOpts = [] }
        (_,xs) -> fail ("Unrecognized flag passed to '-f': "
                        ++ unwords xs ++ "\nValid flags:\n\n" ++ FlagOpts.helpMsg)

getArguments = do
    x <- lookupEnv "JHC_OPTS"
    let eas = maybe [] words x
    as <- System.getArgs
    return (eas ++ as)

pfill ::
    Int            -- ^ maximum width
    -> (a -> Int)  -- ^ find width of any element
    -> [a]         -- ^ input elements
    -> [[a]]       -- ^ output element
pfill maxn length xs = f maxn xs [] [] where
    f n (x:xs) ws ls | lx < n = f (n - lx) xs (x:ws) ls where
        lx = length x
    f _ (x:xs) [] ls = f (maxn - length x) xs [x] ls
    f _ (x:xs) ws ls = f (maxn - length x) xs [x] (ws:ls)
    f _ [] [] ls = reverse (map reverse ls)
    f _ [] ws ls = reverse (map reverse (ws:ls))

helpUsage = usageInfo header theoptions ++ trailer where
    header = "Usage: jhc [OPTION...] Main.hs"
    trailer = "\n" ++ mkoptlist "-d" FlagDump.helpFlags ++ "\n" ++ mkoptlist "-f" FlagOpts.helpFlags
    mkoptlist d os = "valid " ++ d ++ " arguments: 'help' for more info\n    " ++ intercalate "\n    " (map (intercalate ", ") $ pfill 100 ((2 +) . length) os) ++ "\n"

{-# NOINLINE processOptions #-}
-- | Parse commandline options.
processOptions :: IO Opt
processOptions = do
    -- initial argument processing
    argv <- getArguments
    let (o,ns,rc) = getOpt Permute theoptions argv
    o <- return (foldl (flip ($)) emptyOpt o)
    when (rc /= []) $ putErrLn (concat rc ++ helpUsage) >> exitWith exitCodeUsage
    case optStop o of
        StopError s -> putErrLn "bad option passed to --stop should be one of parse, deps, typecheck, or c" >> exitWith exitCodeUsage
        _ -> return ()
    case optMode o of
        ShowHelp    -> doShowHelp
        ShowConfig  -> doShowConfig
        Version     -> putStrLn versionString >> exitSuccess
        VersionCtx  -> putStrLn (versionString ++ BS.toString versionContext) >> exitSuccess
        PrintHscOptions -> do
            putStrLn $ "-I" ++ VC.datadir ++ "/" ++ VC.package ++ "-" ++ VC.shortVersion ++ "/include"
            exitSuccess
        _ -> return ()
    -- read targets.ini file
    Just home <- fmap (`mplus` Just "/") $ lookupEnv "HOME"
    inis <- parseIniFiles (optVerbose o > 0) (BS.toString targets_ini) [confDir ++ "/targets.ini", confDir ++ "/targets-local.ini", home ++ "/etc/jhc/targets.ini", home ++ "/.jhc/targets.ini"] (optArch o)
    -- process dump flags
    o <- either putErrDie return $ postProcessFD o
    when (FlagDump.Ini `S.member` optDumpSet o) $ flip mapM_ (M.toList inis) $ \(a,b) -> putStrLn (a ++ "=" ++ b)
    -- set flags based on ini options
    let o1 = case M.lookup "gc" inis of
            Just "jgc" -> optFOptsSet_u (S.insert FlagOpts.Jgc) o
            Just "boehm" -> optFOptsSet_u (S.insert FlagOpts.Boehm) o
            _ -> o
    o2 <- either putErrDie return $ postProcessFO o1
    when (FlagDump.Ini `S.member` optDumpSet o) $ do
        putStrLn (show $ optDumpSet o)
        putStrLn (show $ optFOptsSet o)
    -- add autoloads based on ini options
    let autoloads = maybe [] (tokens (',' ==)) (M.lookup "autoload" inis)
    return o2 { optArgs = ns, optInis = inis, optAutoLoads = autoloads }

doShowHelp = do
    putStrLn helpUsage
    exitSuccess

doShowConfig = do
    --mapM_ (\ (x,y) -> putStrLn (x ++ ": " ++ y))  configs
    putStrLn $ showYAML  configs
    exitSuccess

findHoCache :: IO (Maybe FilePath)
findHoCache = do
    cd <- lookupEnv "JHC_CACHE"
    case optHoCache options `mplus` cd of
        Just s -> do return (Just s)
        Just "-" -> do return Nothing
        Nothing | isNothing (optHoDir options) -> do
            Just home <- fmap (`mplus` Just "/") $ lookupEnv "HOME"
            let cd = home ++ "/.jhc/cache"
            createDirectoryIfMissing True cd
            return (Just cd)
        _  -> return Nothing

configs :: Node
configs = toNode [
    "jhclibpath" ==> initialLibIncludes,
    "version" ==> version,
    "package" ==> package,
    "libdir" ==> libdir,
    "datadir" ==> datadir,
    "libraryInstall" ==> libraryInstall,
    "host" ==> host
    ] where
    (==>) :: ToNode b => String -> b -> (String,Node)
    a ==> b = (a,toNode b)

{-# NOINLINE fileOptions #-}
fileOptions :: Monad m => Opt -> [String] -> m Opt
fileOptions options xs = case getOpt Permute theoptions xs of
    (os,[],[]) -> postProcessFD (foldl (flip ($)) options os) >>= postProcessFO
    (_,_,errs) -> fail (concat errs)

{-# NOINLINE options #-}
-- | The global options currently used.
options :: Opt
options = unsafePerformIO processOptions

-- | Put a string to stderr when running verbose.
putVerbose :: String -> IO ()
putVerbose s = when (optVerbose options > 0) $ putErr s

-- | Put a line to stderr when running verbose.
putVerboseLn :: String -> IO ()
putVerboseLn s = putVerbose (s ++ "\n")

putProgress :: String -> IO ()
putProgress s = when progress $ putErr s

-- | Put a line to stderr when running verbose.
putProgressLn :: String -> IO ()
putProgressLn s = putProgress (s ++ "\n")

-- | Is verbose > 0?
progress :: Bool
progress = dump FlagDump.Progress

-- | Is verbose > 0?
verbose :: Bool
verbose = optVerbose options > 0
-- | Is verbose > 1?
verbose2 :: Bool
verbose2 = optVerbose options > 1

-- | Test whether a dump flag is set.
dump :: FlagDump.Flag -> Bool
dump s = s `S.member` optDumpSet options
-- | Test whether an option flag is set.
fopts :: FlagOpts.Flag -> Bool
fopts s = s `S.member` optFOptsSet options
-- | Do the action when the suplied dump flag is set.
wdump :: (Monad m) => FlagDump.Flag -> m () -> m ()
wdump f = when (dump f)

-- | Is the \"lint\" option flag set?
flint :: Bool
flint = FlagOpts.Lint `S.member` optFOptsSet options

-- | Include directories taken from JHCPATH enviroment variable.
initialIncludes :: [String]
initialIncludes = unsafePerformIO $ do
    p <- lookupEnv "JHC_PATH"
    let x = fromMaybe "" p
    return (".":(tokens (== ':') x))

-- | Include directories taken from JHCLIBPATH enviroment variable.
initialLibIncludes :: [String]
initialLibIncludes = unsafePerformIO $ do
    ps <- lookupEnv "JHC_LIBRARY_PATH"
    h <- lookupEnv "HOME"
    let paths = h ++ ["/usr/local","/usr"]
        bases = ["/lib","/share"]
        vers = ["/jhc-" ++ shortVersion, "/jhc"]
    return $ nub $ maybe [] (tokens (':' ==))  ps ++ [ p ++ b ++ v | p <- paths, v <- vers, b <- bases ]
               ++ [d ++ v | d <- [libdir,datadir], v <- vers] ++ [libraryInstall]

class Monad m => OptionMonad m where
    getOptions :: m Opt
    getOptions = return options

instance OptionMonad Identity

newtype OptT m a = OptT (ReaderT Opt m a)
    deriving(MonadIO,Monad,Functor,MonadTrans)

type OptM = OptT Identity

instance Monad m => OptionMonad (OptT m) where
    getOptions = OptT ask

withOptions :: Opt -> OptM a -> a
withOptions opt (OptT x) = runIdentity (runReaderT x opt)

withOptionsT :: Opt -> OptT m a -> m a
withOptionsT opt (OptT x) = runReaderT x opt

outputName = fromMaybe "hs.out" (optOutName options)

flagOpt :: OptionMonad m => FlagOpts.Flag -> m Bool
flagOpt flag = do
    opt <- getOptions
    return (flag `S.member` optFOptsSet opt)

getArgString = do
    name <- System.getProgName
    args <- getArguments
    return (simpleQuote (name:args),head $ lines versionString)
