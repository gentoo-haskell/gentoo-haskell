# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=2

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Fully evaluate data structures"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/deepseq"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8"
DEPEND=">=dev-haskell/cabal-1.6
		${RDEPEND}"

src_prepare() {
	# lower drps down to ghc-6.8+
	sed -i \
	    -e 's@containers >= 0.2 && < 0.4@containers >= 0.1 \&\& < 0.4@g' \
	    -e 's@array      >= 0.2 && < 0.4@array      >= 0.1 \&\& < 0.4@g' \
	    "${S}/${PN}.cabal"
}
