# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="A Citation Style Language implementation in Haskell"
HOMEPAGE="http://code.haskell.org/citeproc-hs"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		>=dev-haskell/hxt-8.1
		dev-haskell/mtl"

src_compile() {
    CABAL_CONFIGURE_FLAGS="--constraint=base<4"
    cabal_src_compile
}
