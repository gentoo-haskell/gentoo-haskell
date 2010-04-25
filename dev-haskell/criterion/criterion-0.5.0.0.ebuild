# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit base haskell-cabal

DESCRIPTION="Robust, reliable performance measurement and analysis"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/criterion"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# Current chart usage in criterion is broken
# IUSE="chart"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.1
		>=dev-haskell/deepseq-1.1.0.0
		dev-haskell/mtl
		>=dev-haskell/mwc-random-0.5.0.0
		dev-haskell/parallel
		>=dev-haskell/parsec-3.1.0
		>=dev-haskell/statistics-0.5.1.0
		dev-haskell/time
		>=dev-haskell/vector-0.5
		>=dev-haskell/vector-algorithms-0.3"
#		chart? ( >=dev-haskell/chart-0.12
#				 dev-haskell/data-accessor )"
DEPEND=">=dev-haskell/cabal-1.2
		${RDEPEND}"

src_unpack() {
	base_src_unpack
	cd "${S}"
	epatch "${FILESDIR}/${P}-wide-character.patch"
}

src_compile() {
#	if use chart; then
#		CABAL_CONFIGURE_FLAGS="--flags=chart"
#	else
#		CABAL_CONFIGURE_FLAGS="--flags=-chart"
#	fi

	CABAL_CONFIGURE_FLAGS="--flags=-chart"

	cabal_src_compile
}
