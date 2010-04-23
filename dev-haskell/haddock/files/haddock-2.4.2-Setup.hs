{-
Setup.hs: based on code from ghc-paths of Simon Marlow
Fixed to not use the .buildinfo, and use -Dfoo flags for both libraries and executables

Modified 2010-03-30 to work with both cabal-1.6 and cabal-1.8. See bug #302489.
-}
import Distribution.Simple
import Distribution.Simple.Setup
import Distribution.PackageDescription
import Distribution.Simple.LocalBuildInfo
import Distribution.InstalledPackageInfo
import Distribution.Simple.Program
import Distribution.Simple.PackageIndex as Pkg

import System.Exit
import System.IO
import Data.IORef
import Data.Char
import Data.Maybe

main = defaultMainWithHooks simpleUserHooks {
                      confHook    = myCustomConfHook
                     }
  where
{- With cabal-1.6, myCustomConfHook has this type
    myCustomConfHook :: (Either GenericPackageDescription PackageDescription, HookedBuildInfo)
                     -> ConfigFlags
                     -> IO LocalBuildInfo
   With cabal-1.8, myCustomConfHook has this type
    myCustomConfHook :: (GenericPackageDescription, HookedBuildInfo)

So, better to not specify the type at all as we're not required to...
-}
    myCustomConfHook gpd flags = do
      -- get the default LBI
      lbi <- confHook simpleUserHooks gpd flags
      let programs = withPrograms lbi

      libdir_ <- rawSystemProgramStdoutConf (fromFlag (configVerbosity flags))
                     ghcProgram programs ["--print-libdir"]
      let libdir = reverse $ dropWhile isSpace $ reverse libdir_

          ghc_pkg = case lookupProgram ghcPkgProgram programs of
                          Just p  -> programPath p
                          Nothing -> error "ghc-pkg was not found"
          ghc     = case lookupProgram ghcProgram programs of
                          Just p  -> programPath p
                          Nothing -> error "ghc was not found"

          -- figure out docdir from base's haddock-html field
          base_pkg = case searchByName (installedPkgs lbi) "base" of
                        None -> error "no base package"
                        Unambiguous (x:_) -> x
                        _ -> error "base ambiguous"
          base_html = case haddockHTMLs base_pkg of
                        [] -> ""
                        (x:_) -> x
          docdir = fromMaybe base_html $
                        fmap reverse (stripPrefix (reverse "/libraries/base")
                                                  (reverse base_html))

      let programs' = userSpecifyArgs "ghc" ["-DGHC_PATHS_GHC_PKG=" ++ show ghc_pkg,
                                             "-DGHC_PATHS_GHC=" ++ show ghc,
                                             "-DGHC_PATHS_LIBDIR=" ++ show libdir,
                                             "-DGHC_PATHS_DOCDIR=" ++ show docdir
                                            ] programs
      -- returning our modified LBI that includes the -D definitions
      return lbi { withPrograms = programs' }

die :: String -> IO a
die msg = do
  hFlush stdout
  hPutStr stderr msg
  exitWith (ExitFailure 1)

stripPrefix :: Eq a => [a] -> [a] -> Maybe [a]
stripPrefix [] ys = Just ys
stripPrefix (x:xs) (y:ys)
 | x == y = stripPrefix xs ys
stripPrefix _ _ = Nothing
