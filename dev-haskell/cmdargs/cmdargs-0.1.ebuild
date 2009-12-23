# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Command line argument processing"
HOMEPAGE="http://community.haskell.org/~ndm/cmdargs/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10.1
		>=dev-haskell/cabal-1.6
		dev-haskell/mtl"

src_install() {
	cabal_src_install

	dodoc "${PN}.htm"
}
