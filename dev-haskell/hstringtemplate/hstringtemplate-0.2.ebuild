# Copyright 1999-2007 Gentoo Foundation
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
		>=dev-haskell/cabal-1.2
		dev-haskell/syb-with-class
		dev-haskell/filepath
		dev-haskell/parsec
		dev-haskell/time
		dev-haskell/bytestring"

S="${WORKDIR}/${MY_P}"
