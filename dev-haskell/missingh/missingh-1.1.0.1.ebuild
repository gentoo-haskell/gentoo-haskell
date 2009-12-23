# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="MissingH"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Large utility library"
HOMEPAGE="http://software.complete.org/missingh"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/hslogger
		dev-haskell/hunit
		dev-haskell/mtl
		dev-haskell/network
		dev-haskell/parsec
		>=dev-haskell/quickcheck-1.0
		<dev-haskell/quickcheck-2.0
		dev-haskell/regex-compat"
DEPEND=">=dev-haskell/cabal-1.2.3
		${RDEPEND}"

S="${WORKDIR}/${MY_P}"
