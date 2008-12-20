# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Simple foundation for functional reactive programming"
HOMEPAGE="http://haskell.org/haskellwiki/reactive"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		>=dev-haskell/category-extras-0.53.5
		>=dev-haskell/checkers-0.1.3
		<dev-haskell/quickcheck-2.0
		dev-haskell/stream
		>=dev-haskell/typecompose-0.6.3
		>=dev-haskell/unamb-0.1.2
		>=dev-haskell/vector-space-0.5"
