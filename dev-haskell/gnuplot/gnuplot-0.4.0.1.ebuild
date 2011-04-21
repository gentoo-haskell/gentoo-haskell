# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="2D and 3D plots using gnuplot"
HOMEPAGE="http://www.haskell.org/haskellwiki/Gnuplot"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		<dev-haskell/monoid-transformer-0.1
		>=dev-haskell/time-1.1
		<dev-haskell/utility-ht-0.1
		sci-visualization/gnuplot"

DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

src_prepare() {
	# Remove restrictions on time
	sed -i -e 's/time >= 1.1 && < 1.2/time >= 1.1/' \
				"${S}/${PN}.cabal"
}
