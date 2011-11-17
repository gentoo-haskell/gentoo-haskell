# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="Memoize Strings as Atoms for fast comparison and sorting, with maps and sets"
HOMEPAGE="http://hackage.haskell.org/package/stringtable-atom"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.1
		dev-haskell/binary"
DEPEND=">=dev-haskell/cabal-1.2.3
		${RDEPEND}"
