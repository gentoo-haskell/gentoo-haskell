# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Display GHC's core and assembly output in a pager"
HOMEPAGE="http://code.haskell.org/~dons/code/ghc-core"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		dev-haskell/colorize-haskell
		dev-haskell/filepath
		dev-haskell/pcre-light"

src_compile() {
    CABAL_CONFIGURE_FLAGS="--constraint=base<4"
    cabal_src_compile
}

