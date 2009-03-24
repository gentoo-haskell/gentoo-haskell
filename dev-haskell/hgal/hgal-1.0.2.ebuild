# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="library for computation automorphism group and canonical labelling of a graph"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/${PN}"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/cabal
		=dev-haskell/mtl-1.1*"

src_unpack() {
	unpack ${A}

	# Remove restrictions on array and containers
	sed -i -e 's/containers >= 0.1 && <0.2/containers >= 0.1/' \
				 "${S}/${PN}.cabal"
	sed -i -e 's/array >= 0.1 && <0.2/array >= 0.1/' \
				 "${S}/${PN}.cabal"
}
