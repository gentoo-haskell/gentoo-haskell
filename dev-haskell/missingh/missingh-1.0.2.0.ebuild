# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="MissingH"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Large utility library"
HOMEPAGE="http://software.complete.org/missingh"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""
SLOT="0"

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		dev-haskell/network
		dev-haskell/parsec
		dev-haskell/mtl
		dev-haskell/hunit
		dev-haskell/regex-compat
		=dev-haskell/quickcheck-1*
		dev-haskell/filepath
		dev-haskell/hslogger"

S="${WORKDIR}/${MY_P}"


src_unpack() {
	unpack ${A}

	# MissingH doesn't support quickcheck 2
	sed -e 's/QuickCheck/QuickCheck>=1\&\&<2/' \
		-i "${S}/MissingH.cabal"
}
