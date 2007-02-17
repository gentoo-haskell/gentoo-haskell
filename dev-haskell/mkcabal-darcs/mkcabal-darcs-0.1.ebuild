# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EDARCS_REPOSITORY="http://www.cse.unsw.edu.au/~dons/code/mkcabal/"
EDARCS_LOCALREPO="mkcabal-darcs"
EDARCS_GET_CMD="get --partial --verbose"

CABAL_FEATURES="bin"
inherit haskell-cabal darcs

DESCRIPTION="Generate .cabal files"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/code/mkcabal/"
LICENSE="GPL-2"
SLOT="${PV}"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=virtual/ghc-6.6
	>=dev-haskell/mtl-1.0-r1"
