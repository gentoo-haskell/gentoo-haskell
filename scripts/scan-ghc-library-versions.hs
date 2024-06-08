-- Usage: runhaskell scan-ghc-library-versions.hs [OPTION...] <GHC version>
--
-- This utility is to be used in a GHC git repository:
-- git clone https://gitlab.haskell.org/ghc/ghc.git/
--
-- WARNING: This utility will wipe all changes from the local git repo!
-- Only use this in a throwaway git repo!

{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE PackageImports #-}

module Main (main) where

import Control.Monad
import qualified Data.ByteString as BS
import Data.Foldable (toList)
import Data.Functor.Const (Const(..))
import Data.Functor.Identity (Identity(..))
-- import Data.List (intercalate)
import "Cabal-syntax" Distribution.InstalledPackageInfo
    (InstalledPackageInfo, parseInstalledPackageInfo)
import "Cabal-syntax" Distribution.Package
    (packageName, packageVersion)
import "Cabal-syntax" Distribution.Pretty
    (pretty)
import Distribution.Simple.Utils (warn)
import Distribution.Verbosity
import System.Console.GetOpt
import System.Directory
import System.Environment (getProgName, getArgs)
import System.FilePath
import System.Exit (ExitCode(..), exitSuccess, die)
import System.IO (stderr, hPutStr, hPutStrLn, hGetContents)
import System.Process
import qualified Text.PrettyPrint as PP
-- import Text.Read (readMaybe)

type Version = String

data CabalFile
    = CabalFile FilePath
    | CabalIn FilePath

data Library f = Lib
    String -- name
    FilePath -- directory
    (f CabalFile) -- cabal file; not initialized at first

type Lib = Library (Const ()) -- No cabal file located yet
type LibLocated = Library Identity

libraries :: [Lib]
libraries =
    [ lib "Cabal-syntax" ("libraries" </> "Cabal" </> "Cabal-syntax")
    , lib "Cabal" ("libraries" </> "Cabal" </> "Cabal")
    , stdlib "array"
    , stdlib "base"
    , stdlib "binary"
    , stdlib "bytestring"
    , lib "containers" ("libraries" </> "containers" </> "containers")
    , stdlib "deepseq"
    , stdlib "directory"
    , stdlib "exceptions"
    , stdlib "filepath"
    , stdlib "ghc-bignum"
    , stdlib "ghc-boot"
    , stdlib "ghc-boot-th"
    , stdlib "ghc-compact"
    , stdlib "ghc-heap"
    , stdlib "ghc-platform"
    , stdlib "ghc-prim"
    , lib "ghc-toolchain" ("utils" </> "ghc-toolchain")
    , stdlib "ghci"
    , stdlib "haskeline"
    , stdlib "hpc"
    , stdlib "integer-gmp"
    , stdlib "mtl"
    , stdlib "parsec"
    , stdlib "pretty"
    , stdlib "process"
    , stdlib "semaphore-compat"
    , stdlib "stm"
    , stdlib "template-haskell"
    , stdlib "terminfo"
    , stdlib "text"
    , stdlib "time"
    , stdlib "transformers"
    , stdlib "unix"
    , stdlib "xhtml"
    ]

main :: IO ()
main = do
    (v, isV) <- checkArgs
    let branch = "ghc-" ++ v ++ "-release"
        verb = if isV then normal else silent

    gitCmd isV ["checkout", "--force", branch]
    gitCmd isV ["submodule", "foreach", "--recursive", "git", "reset", "--hard"]
    gitCmd isV ["submodule", "update", "--init", "--recursive"]
    gitCmd isV ["clean", "-d", "-f", "-f"]

    libDocs <- forM libraries $ locateLib >=> \case
        Left w -> do
            warn verb w
            pure PP.empty
        Right (Lib name _dir (Identity cabalFile)) -> case cabalFile of
            -- .cabal.in files should have a fallback if they cannot be parsed
            CabalIn cabalPath -> do
                bs <- BS.readFile cabalPath
                pure $ case parseInstalledPackageInfo bs of
                    Left _ -> -- fallback
                        PP.fsep $ PP.punctuate PP.colon
                            [ PP.text name
                            , PP.text "@ProjectVersionMunged@" ]
                    Right (_, ipi) -> printLib ipi
            CabalFile cabalPath -> do
                bs <- BS.readFile cabalPath
                case parseInstalledPackageInfo bs of
                    Left errs -> die $ unwords
                        ["Errors when parsing", cabalPath, ":", show (toList errs)]
                    Right (_, ipi) -> pure (printLib ipi)

    putStrLn $ PP.render $ PP.vcat libDocs
  where
    printLib :: InstalledPackageInfo -> PP.Doc
    printLib ipi = PP.fsep $ PP.punctuate PP.colon
        [ pretty (packageName ipi), pretty (packageVersion ipi) ]

locateLib :: Lib -> IO (Either String LibLocated)
locateLib (Lib n d _) = do
    let mkLib = Right . Lib n d . Identity
        cn = d </> n <.> "cabal"
        cd = d </> n <.> "cabal.in"
    cnExists <- doesFileExist cn
    cdExists <- doesFileExist cd
    pure $ case (cnExists, cdExists) of
        (True, _) -> mkLib (CabalFile cn)
        (_, True) -> mkLib (CabalIn cd)
        _ -> Left $ unwords
            [ "Cannot find", show cn, "or", show cd ]

-- Standard location for a library
stdlib :: String -> Lib
stdlib n = lib n ("libraries" </> n)

-- Smart constructor for an uninitialized Library
lib :: String -> FilePath -> Lib
lib n p = Lib n p (Const ())

-- Run a git command. stdout is redirected to stderr when verbose or
-- /dev/null otherwise. Errors are fatal.
gitCmd :: Verbose -> [String] -> IO ()
gitCmd isV args = findExecutable "git" >>= \case
    Nothing -> die "Cannot find git executable (install dev-vcs/git?)"
    Just exe -> do

        let cp = (proc exe args)
                { std_out = CreatePipe
                , std_err = CreatePipe }

        withCreateProcess cp $ \_ mHOut mHErr ph -> case (mHOut, mHErr) of
            (Just hOut, Just hErr) ->
                waitForProcess ph >>= \case
                    ExitSuccess
                        | isV -> dumpHandles [hOut, hErr] stderr
                        | otherwise -> pure ()
                    ExitFailure i -> do
                        dumpHandles [hOut, hErr] stderr
                        die $ unwords
                            [ "Command failed with exit code", show i ++ ":"
                            , unwords (show <$> exe : args) ]
            _ -> undefined
  where
    dumpHandles hs hOut = mapM_ (hPutStr hOut <=< hGetContents) hs

type Verbose = Bool

data Mode
    = HelpMode
    | NormalMode Verbose
    deriving (Show, Eq, Ord)

instance Semigroup Mode where
    HelpMode <> _ = HelpMode
    _ <> HelpMode = HelpMode
    NormalMode b1 <> NormalMode b2 = NormalMode (b1 || b2)

instance Monoid Mode where
    mempty = NormalMode False

-- Parses the version number and any mode info from the command line
checkArgs :: IO (Version, Verbose)
checkArgs = do
    progName <- getProgName
    argv <- getArgs
    let err str = showHelp progName *> die str

    case getOpt Permute options argv of
        (_,_,es@(_:_)) -> err (concat es)

        (ms,as,_) -> case (mconcat ms, as) of
            (HelpMode, _) -> showHelp progName *> exitSuccess
            (_, []) -> err "GHC version argument required"
            (_,(_:as'@(_:_))) -> err
                ("Extra command-line arguments given: " ++ show as')
            (NormalMode isV, [vStr]) -> pure (vStr, isV)
  where
    showHelp progName = hPutStrLn stderr (usageInfo (header progName) options)

    header progName = unlines $ unwords <$>
        [ ["Usage: runhaskell", progName, "[OPTION...]", "<GHC version>"]
        , []
        , ["This utility is to be used in a GHC git repository:"]
        , ["git clone https://gitlab.haskell.org/ghc/ghc.git/"]
        , []
        , ["WARNING: This utility will wipe all changes from the local git repo!"]
        , ["Only use this in a throwaway git repo!"]
        ]

    options :: [OptDescr Mode]
    options =
        [ Option ['h'] ["help"] (NoArg HelpMode) "Show this help text"
        , Option ['v'] ["verbose"] (NoArg (NormalMode True)) "Show debug output"
        ]

--     parseVersion :: String -> Maybe [Int]
--     parseVersion s = case span (/= '.') s of
--         (iStr, (_:rest)) ->
--             (:) <$> readMaybe iStr <*> parseVersion rest
--         (end, []) -> (:[]) <$> readMaybe end
