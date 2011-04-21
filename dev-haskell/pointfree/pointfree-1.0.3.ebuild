# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Pointfree refactoring tool"
HOMEPAGE="http://haskell.org/haskellwiki/Pointfree"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		dev-haskell/cabal
		dev-haskell/mtl
		dev-haskell/parsec
		>=dev-lang/ghc-6.8.1"
