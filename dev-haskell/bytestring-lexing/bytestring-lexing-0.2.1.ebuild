# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="Parse literals efficiently from bytestrings"
HOMEPAGE="http://code.haskell.org/~dons/code/bytestring-lexing"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1"
DEPEND=">=dev-haskell/cabal-1.2
		dev-haskell/alex
		${RDEPEND}"
