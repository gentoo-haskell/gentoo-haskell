# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Robust, reliable performance measurement and analysis"
HOMEPAGE="http://bitbucket.org/bos/criterion"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="chart"

RDEPEND=">=dev-haskell/deepseq-1.1.0.0
		dev-haskell/mtl
		>=dev-haskell/mwc-random-0.8.0.3
		>=dev-haskell/parsec-3.1.0
		>=dev-haskell/statistics-0.8.0.5
		dev-haskell/time
		>=dev-haskell/vector-0.7.0.0
		>=dev-haskell/vector-algorithms-0.4
		>=dev-lang/ghc-6.8.2
		chart? ( <dev-haskell/chart-0.15
				 dev-haskell/data-accessor )"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_configure() {
	cabal_src_configure $(cabal_flag chart) $(cabal_flag chart gtk)
}
