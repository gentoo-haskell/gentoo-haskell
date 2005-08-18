-- A program for generating a hc package file from a .cabal file
--
-- Author : Lennart Kolmodin <kolmodin@dtek.chalmers.se>
--
-- Created: 25 July 2005
--
-- Copyright (C) 2005 Lennart Kolmodin
--
-- This library is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
--
-- This library is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- General Public License for more details.
--
-- |
-- Maintainer  : haskell@gentoo.org
--
-- cabal2conf - a program for generating a hc package file from a .cabal file
--
module Main (main) where

-- stdlib imports. compatible with ghc-6.2.2
import Control.Monad ( unless )
import System.Directory ( doesFileExist )
import System.Exit

-- cabal imports. should be compatible with Cabal-0.5 but not tested
import qualified Distribution.Simple.Utils as Cabal ( defaultPackageDesc )                               
import qualified Distribution.Simple.Configure as Cabal ( getPersistBuildConfig )
import qualified Distribution.Simple.Utils as Cabal ( die )
import qualified Distribution.PackageDescription as Cabal ( hasLibs, readPackageDescription )
import qualified Distribution.Simple.Register as Cabal ( writeInstalledConfig, installedPkgConfigFile )

main :: IO ()
main = do
  -- find mypackage.cabal
  pkg_descr_file <- Cabal.defaultPackageDesc
  pkg_descr <- Cabal.readPackageDescription pkg_descr_file
  -- read ./setup configure settings from .setup-config
  lbi <- Cabal.getPersistBuildConfig
  if Cabal.hasLibs pkg_descr then (do
    -- writes the package file to .installed-pkg-config
    Cabal.writeInstalledConfig pkg_descr lbi
    successful <- doesFileExist Cabal.installedPkgConfigFile
    unless successful $ Cabal.die "Package file didn't get created as it should have"
    packageFile <- readFile Cabal.installedPkgConfigFile
    putStr packageFile) else exitWith (ExitFailure 2)

