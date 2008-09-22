# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="RJson"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A reflective JSON serializer/parser."
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.2
		dev-haskell/iconv
		dev-haskell/mtl
		dev-haskell/parsec
		dev-haskell/syb-with-class"

S="${WORKDIR}/${MY_P}"
