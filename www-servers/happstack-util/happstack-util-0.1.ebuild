# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Web framework"
HOMEPAGE="http://happstack.com"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.2.3
		dev-haskell/extensible-exceptions
		>=dev-haskell/hslogger-1.0.2
		dev-haskell/hunit
		dev-haskell/mtl
		=dev-haskell/quickcheck-1*"

src_compile() {
	CABAL_CONFIGURE_FLAGS='--constraint=QuickCheck<2 --flags=-tests'
	cabal_src_compile
}
