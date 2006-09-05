# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="haddock lib bin"
inherit haskell-cabal

DESCRIPTION="Automatic installer for Cabal packages."
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/${P}.tgz"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86"	#if possible try testing with "~amd64", "~ppc" and "~sparc"
IUSE=""

DEPEND=">=virtual/ghc-6.2.2
		dev-haskell/cabal
		dev-haskell/hackage-client
		dev-haskell/filepath
		dev-haskell/gnupg
		dev-haskell/http"

