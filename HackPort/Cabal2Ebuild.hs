-- A program for generating a Gentoo ebuild from a .cabal file
--
-- Author : Duncan Coutts <dcoutts@gentoo.org>
--
-- Created: 21 July 2005
--
-- Copyright (C) 2005 Duncan Coutts
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
-- cabal2ebuild - a program for generating a Gentoo ebuild from a .cabal file
--
module Cabal2Ebuild
	(EBuild(..)
	,cabal2ebuild
	,showEBuild) where

import qualified Distribution.PackageDescription as Cabal
                                                (PackageDescription(..),
                                                 readPackageDescription)
import qualified Distribution.Package as Cabal  (PackageIdentifier(..))
import qualified Distribution.Version as Cabal  (showVersion, Dependency(..),
                                                 VersionRange(..))
import qualified Distribution.License as Cabal  (License(..))
--import qualified Distribution.Compiler as Cabal (CompilerFlavor(..))

import Data.Char          (toLower,isUpper)
import Data.Maybe         (catMaybes)
import Text.Regex

data EBuild = EBuild {
    name :: String,
    version :: String,
    description :: String,
    homepage :: String,
    src_uri :: String,
    license :: String,
    slot :: String,
    keywords :: [String],
    iuse :: [String],
    depend :: [Dependency],
    features :: [String],
    -- comments on various fields for communicating stuff to the user
    licenseComments :: String,
    cabalPath :: Maybe String, --If it's not ${WORKDIR}/${P}
    my_pn :: Maybe String --If the package's name contains upper-case
  }

type Package = String
type Version = String
type UseFlag = String
data Dependency = AnyVersionOf               Package
                | ThisVersionOf      Version Package   -- =package-version
                | LaterVersionOf     Version Package   -- >package-version
                | EarlierVersionOf   Version Package   -- <package-version
                | OrLaterVersionOf   Version Package   -- >=package-version
                | OrEarlierVersionOf Version Package   -- <=package-version
                | DependEither Dependency Dependency   -- depend || depend
                | DependIfUse  UseFlag    Dependency   -- use? ( depend )

ebuildTemplate = EBuild {
    name = "foobar",
    version = "0.1",
    description = "",
    homepage = "",
    src_uri = "",
    license = "",
    slot = "0",
    keywords = ["~x86"],
    iuse = [],
    depend = [],
    features = ["haddock"],
    licenseComments = "",
    cabalPath = Nothing,
    my_pn = Nothing
  }

cabal2ebuild :: Cabal.PackageDescription -> EBuild
cabal2ebuild pkg = ebuildTemplate {
    name        = map toLower cabalPkgName,
    version     = Cabal.showVersion (Cabal.pkgVersion (Cabal.package pkg)),
    description = if null (Cabal.synopsis pkg) then Cabal.description pkg
                                               else Cabal.synopsis pkg,
    homepage        = Cabal.homepage pkg,
    src_uri         = Cabal.pkgUrl pkg,
    license         = convertLicense (Cabal.license pkg),
    licenseComments = licenseComment (Cabal.license pkg),
    depend          = defaultDepGHC
                    : convertDependencies (Cabal.buildDepends pkg),
    my_pn = if any isUpper cabalPkgName then Just cabalPkgName else Nothing
  } where
  	cabalPkgName = Cabal.pkgName (Cabal.package pkg)

defaultDepGHC     = OrLaterVersionOf "6.2.2" "virtual/ghc"

-- map the cabal license type to the gentoo license string format
convertLicense :: Cabal.License -> String
convertLicense Cabal.GPL          = "GPL-2"    -- almost certainly version 2
convertLicense Cabal.LGPL         = "LGPL-2.1" -- probably version 2.1
convertLicense Cabal.BSD3         = "BSD"      -- do we really not
convertLicense Cabal.BSD4         = "BSD"      -- distinguish between these?
convertLicense Cabal.PublicDomain = "public-domain"
convertLicense Cabal.AllRightsReserved = ""
convertLicense _                  = ""

licenseComment Cabal.AllRightsReserved =
  "Note: packages without a license cannot be included in portage"
licenseComment Cabal.OtherLicense =
  "Fixme: \"OtherLicense\", please fill in manually"
licenseComment _ = ""

convertDependencies :: [Cabal.Dependency] -> [Dependency]
convertDependencies = catMaybes . map convertDependency

convertDependency :: Cabal.Dependency -> Maybe Dependency
convertDependency (Cabal.Dependency name versionRange)
  | name `elem` standardLibs = Nothing      -- no explicit dep on standard libs
  | otherwise                = Just $ convert versionRange

  where
    ebuildName = "dev-haskell/" ++ map toLower name
    
    convert :: Cabal.VersionRange -> Dependency
    convert Cabal.AnyVersion = AnyVersionOf ebuildName
    convert (Cabal.ThisVersion v) = ThisVersionOf (Cabal.showVersion v) ebuildName
    convert (Cabal.LaterVersion v)   = LaterVersionOf (Cabal.showVersion v) ebuildName
    convert (Cabal.EarlierVersion v) = EarlierVersionOf (Cabal.showVersion v) ebuildName
    convert (Cabal.UnionVersionRanges (Cabal.ThisVersion v1) (Cabal.LaterVersion v2))
      | v1 == v2 = OrLaterVersionOf (Cabal.showVersion v1) ebuildName
    convert (Cabal.UnionVersionRanges (Cabal.ThisVersion v1) (Cabal.EarlierVersion v2))
      | v1 == v2 = OrEarlierVersionOf (Cabal.showVersion v1) ebuildName
    convert (Cabal.UnionVersionRanges r1 r2)
      = DependEither (convert r1) (convert r2)
--    convert (Cabal.IntersectVersionRanges r1 r2)
--      = convert r1 ++ "&&" ++ convert r2

standardLibs =
  ["rts"
  ,"base"
  ,"haskell98"
  ,"template-haskell"
  ,"unix"
  ,"parsec"
  ,"haskell-src"
  ,"network"
  ,"QuickCheck"
  ,"HUnit"
  ,"stm"
  ,"readline"
  ,"lang"
  ,"concurrent"
  ,"posix"
  ,"util"
  ,"data"
  ,"text"
  ,"net"
  ,"hssource"
  ,"mtl"]

showEBuild :: EBuild -> String
showEBuild ebuild =
  ss "# Copyright 1999-2005 Gentoo Foundation". nl.
  ss "# Distributed under the terms of the GNU General Public License v2". nl.
  ss "# $Header:  $". nl.
  nl.
  ss "CABAL_FEATURES=". quote' (sepBy " " $ features ebuild). nl.
  ss "inherit haskell-cabal". nl.
  nl.
  (maybe id (\x->ss "MY_P=". quote x. nl) (my_pn ebuild)).
  ss "DESCRIPTION=". quote (description ebuild). nl.
  ss "HOMEPAGE=". quote (homepage ebuild). nl.
  ss "SRC_URI=". quote (replaceVars (src_uri ebuild)).
     (if null (src_uri ebuild) then ss "\t#Fixme: please fill in manually"
         else id). nl.
  ss "LICENSE=". quote (license ebuild).
     (if null (licenseComments ebuild) then id
         else ss "\t#". ss (licenseComments ebuild)). nl.
  ss "SLOT=". quote (slot ebuild). nl.
  nl.
  ss "KEYWORDS=". quote' (sepBy ", " $ keywords ebuild).
     (ss "\t#if possible try testing with \"~amd64\", \"~ppc\" and \"~sparc\""). nl.
  ss "IUSE=". quote' (sepBy ", " $ iuse ebuild). nl.
  nl.
  ss "DEPEND=". quote' (sepBy "\n\t\t" $ map showDepend $ depend ebuild). nl.
     (case cabalPath ebuild of Nothing -> id ; Just cp -> if cp==((name ebuild)++"-"++(version ebuild)) then id else nl. ss "S=". quote ("${WORKDIR}/"++(replaceVars cp)). nl)
  $ []
  where replaceVars = replaceCommonVars (name ebuild) (my_pn ebuild) (version ebuild)

showDepend (AnyVersionOf               package) = package
showDepend (ThisVersionOf      version package) = "=" ++ package ++ "-" ++ version
showDepend (LaterVersionOf     version package) = ">" ++ package ++ "-" ++ version
showDepend (EarlierVersionOf   version package) = "<" ++ package ++ "-" ++ version
showDepend (OrLaterVersionOf   version package) = ">=" ++ package ++ "-" ++ version
showDepend (OrEarlierVersionOf version package) = "<=" ++ package ++ "-" ++ version
showDepend (DependEither       depend1 depend2) = showDepend depend1
                                     ++ " || " ++ showDepend depend2
showDepend (DependIfUse        useflag depend@(DependEither _ _)) 
                                                = useflag ++ "? " ++ showDepend depend
showDepend (DependIfUse        useflag depend)  = useflag ++ "? ( " ++ showDepend depend ++ " )"

ss = showString
sc = showChar
nl = sc '\n'

quote str = sc '"'. ss str. sc '"'
quote' str = sc '"'. str. sc '"'

sepBy :: String -> [String] -> ShowS
sepBy s []     = id
sepBy s [x]    = ss x
sepBy s (x:xs) = ss x. ss s. sepBy s xs

getRestIfPrefix ::
	String ->	-- ^ the prefix
	String ->	-- ^ the string
	Maybe String
getRestIfPrefix (p:ps) (x:xs) = if p==x then getRestIfPrefix ps xs else Nothing
getRestIfPrefix [] rest = Just rest
getRestIfPrefix _ [] = Nothing

subStr ::
	String ->	-- ^ the search string
	String ->	-- ^ the string to be searched
	Maybe (String,String)	-- ^ Just (pre,post) if string is found
subStr sstr str = case getRestIfPrefix sstr str of
	Nothing -> if null str then Nothing else case subStr sstr (tail str) of
		Nothing -> Nothing
		Just (pre,post) -> Just (head str:pre,post)
	Just rest -> Just ([],rest)

replaceMultiVars ::
	[(String,String)] ->	-- ^ pairs of variable name and content
	String ->		-- ^ string to be searched
	String 			-- ^ the result
replaceMultiVars [] str = str
replaceMultiVars whole@((name,cont):rest) str = case subStr cont str of
	Nothing -> replaceMultiVars rest str
	Just (pre,post) -> (replaceMultiVars rest pre)++name++(replaceMultiVars whole post)

replaceCommonVars ::
	String ->	-- ^ PN
	Maybe String ->	-- ^ MYPN
	String ->	-- ^ PV
	String ->	-- ^ the string to be replaced
	String
replaceCommonVars pn mypn pv str
	= replaceMultiVars
		([("${P}",pn++"-"++pv)]
		++ maybe [] (\x->[("${MY_P}",x++"-"++pv)]) mypn
		++[("${PN}",pn)]
		++ maybe [] (\x->[("${MY_PN}",x)]) mypn
		++[("${PV}",pv)]) str
