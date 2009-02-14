# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal eutils

MY_PN="MissingH"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Large utility library"
HOMEPAGE="http://software.complete.org/missingh"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		dev-haskell/filepath
		dev-haskell/hslogger
		dev-haskell/hunit
		dev-haskell/mtl
		dev-haskell/network
		dev-haskell/parsec
		=dev-haskell/quickcheck-1*
		dev-haskell/regex-compat"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	sed -e 's/Library/Library\n  Build-Depends: base < 4/' \
	  -i "${S}/${MY_PN}.cabal"

	cd "${S}"
	# type definitions cannot have haddock comments
	epatch "${FILESDIR}/${P}-haddock.patch"
}
