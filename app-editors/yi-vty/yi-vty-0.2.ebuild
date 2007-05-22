# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib"
inherit haskell-cabal eutils

DESCRIPTION="vty backend for the Yi editor"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/yi.html"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.6
	>=dev-haskell/vty-3.0.0
	>=dev-haskell/filepath-1.0"

