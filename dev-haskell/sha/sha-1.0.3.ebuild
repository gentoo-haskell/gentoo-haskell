# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="SHA"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Implementations of the SHA suite of message digest functions"
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.6
		=dev-haskell/quickcheck-1*"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	# set buildable:False for the test_sha executable,
	# it only contains quickcheck tests
	sed -e 's/\(test_sha\)/\1\n  buildable: False/g' \
		  -i "${S}/${MY_PN}.cabal"
}
