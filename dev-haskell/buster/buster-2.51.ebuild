# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="lib profile haddock"
inherit base haskell-cabal

DESCRIPTION="Almost but not quite entirely unlike FRP"
HOMEPAGE="http://vis.renci.org/jeff/buster"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/binary
		dev-haskell/cabal
		dev-haskell/dataenc
		dev-haskell/mtl
		>=dev-haskell/parsec-3.0.0
		dev-haskell/time"

PATCHES=("${FILESDIR}/${P}-ghc-7.patch")
