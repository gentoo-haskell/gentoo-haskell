#! /usr/bin/env runhaskell

{-# LANGUAGE NoImplicitPrelude, UnicodeSyntax #-}

module Main (main) where


-------------------------------------------------------------------------------
-- Imports
-------------------------------------------------------------------------------

-- from base
import System.IO ( IO )

-- from cabal
import Distribution.Simple ( defaultMainWithHooks
                           , simpleUserHooks
                           , UserHooks(haddockHook)
                           )

import Distribution.Simple.LocalBuildInfo ( LocalBuildInfo(..) )
import Distribution.Simple.Program        ( userSpecifyArgs )
import Distribution.Simple.Setup          ( HaddockFlags )
import Distribution.PackageDescription    ( PackageDescription(..) )


-------------------------------------------------------------------------------
-- Cabal setup program which sets the CPP define '__HADDOCK __' when haddock is run.
-------------------------------------------------------------------------------

main ∷ IO ()
main = defaultMainWithHooks hooks
  where
    hooks = simpleUserHooks { haddockHook = haddockHook' }

-- Define __HADDOCK__ for CPP when running haddock.
haddockHook' ∷ PackageDescription → LocalBuildInfo → UserHooks → HaddockFlags → IO ()
haddockHook' pkg lbi =
  haddockHook simpleUserHooks pkg (lbi { withPrograms = p })
  where
    p = userSpecifyArgs "haddock" ["--optghc=-D__HADDOCK__"] (withPrograms lbi)


-- The End ---------------------------------------------------------------------
