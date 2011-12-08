# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="Monad classes, using type families"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/monads-tf"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.1
		>=dev-haskell/transformers-0.2"
DEPEND=">=dev-haskell/cabal-1.2.3
		${RDEPEND}"
