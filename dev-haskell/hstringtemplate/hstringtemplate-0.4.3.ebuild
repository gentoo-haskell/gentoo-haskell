# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="HStringTemplate"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="StringTemplate implementation in Haskell."
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.2
		dev-haskell/filepath
		<dev-haskell/parsec-3
		dev-haskell/syb-with-class
		dev-haskell/time"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	# add dependency syb
	sed -e "s/array/array, syb/" -i "${S}/${MY_PN}.cabal"
}
