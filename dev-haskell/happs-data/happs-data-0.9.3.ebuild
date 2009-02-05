# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="HAppS-Data"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="HAppS data manipulation libraries"
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/binary
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.2
		>=dev-haskell/happs-util-0.9.3
		=dev-haskell/haxml-1.13*
		dev-haskell/mtl
		dev-haskell/syb
		>=dev-haskell/syb-with-class-0.4"

S="${WORKDIR}/${MY_P}"
