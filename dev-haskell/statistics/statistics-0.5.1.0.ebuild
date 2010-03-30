# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="A library of statistical types, data, and functions"
HOMEPAGE="http://darcs.serpentine.com/statistics"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.1
		dev-haskell/erf
		>=dev-haskell/mwc-random-0.5.0.0
		dev-haskell/primitive
		dev-haskell/time
		>=dev-haskell/vector-0.5
		>=dev-haskell/vector-algorithms-0.3"
DEPEND=">=dev-haskell/cabal-1.2
		${RDEPEND}"
