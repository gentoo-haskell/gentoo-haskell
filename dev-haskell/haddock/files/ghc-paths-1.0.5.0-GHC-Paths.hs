{-# LANGUAGE CPP #-}

module GHC.Paths (
        ghc, ghc_pkg, libdir, docdir
  ) where

libdir, docdir, ghc, ghc_pkg :: FilePath

libdir  = GHC_PATHS_LIBDIR
docdir  = GHC_PATHS_DOCDIR

ghc     = GHC_PATHS_GHC
ghc_pkg = GHC_PATHS_GHC_PKG
