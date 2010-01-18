# Copyright 1999-2009 Gentoo Foundation
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
IUSE="chart"

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		dev-haskell/mtl
		dev-haskell/parallel
		dev-haskell/parsec
		>=dev-haskell/statistics-0.3.5
		dev-haskell/time
		>=dev-haskell/uvector-0.1.0.5
		>=dev-haskell/uvector-algorithms-0.2
		>=dev-haskell/deepseq-1.1.0.0
		chart? ( >=dev-haskell/chart-0.12
				 dev-haskell/data-accessor )"

src_unpack() {
	base_src_unpack
	cd "${S}"
	epatch "${FILESDIR}/${P}-wide-character.patch"
}

src_compile() {
	if use chart; then
		CABAL_CONFIGURE_FLAGS="--flags=chart"
	else
		CABAL_CONFIGURE_FLAGS="--flags=-chart"
	fi

	cabal_src_compile
}
