# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="HAppS-State"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Event-based distributed state."
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/cabal
		=dev-haskell/haxml-1.13*
		dev-haskell/mtl
		dev-haskell/network
		dev-haskell/stm
		>=dev-haskell/hslogger-1.0.2
		>=dev-haskell/happs-util-0.9.2
		>=dev-haskell/happs-data-0.9.2
		dev-haskell/bytestring
		dev-haskell/binary
		dev-haskell/filepath"

S="${WORKDIR}/${MY_P}"
