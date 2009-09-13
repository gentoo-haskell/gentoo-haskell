# Copyright 1999-2009 Gentoo Foundation
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

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		dev-haskell/erf
		dev-haskell/mersenne-random
		>=dev-haskell/uvector-0.1.0.4
		>=dev-haskell/uvector-algorithms-0.2"
