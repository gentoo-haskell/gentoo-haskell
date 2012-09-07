# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="LRU"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Implements an LRU data structure"
HOMEPAGE="http://www.imperialviolet.org/lru"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# could possibly do on ghc 6.6.1 too, but needs cabal patching
# currently it has a unconditional dep on the containers package
DEPEND=">=dev-lang/ghc-6.8.2
		>=dev-haskell/cabal-1.2
		dev-haskell/quickcheck"

S="${WORKDIR}/${MY_P}"
