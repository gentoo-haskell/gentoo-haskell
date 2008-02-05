# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Generates sequence diagrams from textual descriptions"
HOMEPAGE="http://adept.linux.kiev.ua/repos/flow2dot"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/cabal
		>=dev-haskell/mtl-1.0
		dev-haskell/quickcheck
		dev-haskell/parsec"
