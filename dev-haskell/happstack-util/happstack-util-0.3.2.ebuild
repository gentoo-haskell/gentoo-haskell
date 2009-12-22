# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit base haskell-cabal

DESCRIPTION="Web framework"
HOMEPAGE="http://happstack.com"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6
		dev-haskell/extensible-exceptions
		dev-haskell/filepath
		>=dev-haskell/hslogger-1.0.2
		dev-haskell/hunit
		dev-haskell/mtl
		>=dev-haskell/network-2.2
		<dev-haskell/parsec-3
		<dev-haskell/quickcheck-2
		<dev-haskell/smtpclient-1.1
		dev-haskell/strict-concurrency
		dev-haskell/time
		dev-haskell/unix-compat"

src_unpack() {
	base_src_unpack
	sed -i -e "s/Happstack.Util.Testing,//" "${S}/${PN}.cabal"
}
