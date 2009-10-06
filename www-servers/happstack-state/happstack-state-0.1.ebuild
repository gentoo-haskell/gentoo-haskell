# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Event-based distributed state."
HOMEPAGE="http://happstack.com"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/binary
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.2.3
		dev-haskell/extensible-exceptions
		dev-haskell/filepath
		www-servers/happstack-data
		www-servers/happstack-util
		>=dev-haskell/hslogger-1.0.2
		>=dev-haskell/hspread-0.3
		dev-haskell/hunit
		dev-haskell/mtl
		dev-haskell/quickcheck
		dev-haskell/stm
		dev-haskell/syb"

src_compile() {
	CABAL_CONFIGURE_FLAGS='--constraint=QuickCheck<2 --flags=-tests'
	cabal_src_compile
}
