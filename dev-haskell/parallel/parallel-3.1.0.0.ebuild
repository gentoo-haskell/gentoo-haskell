# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=2

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Parallel programming library"
HOMEPAGE="http://hackage.haskell.org/package/parallel"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-haskell/deepseq-1.1*
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	# lower drps down to ghc-6.8+
	sed -i \
	    -e 's@base    >= 4 && < 5@base    >= 3 \&\& < 5@g' \
	    -e 's@containers >= 0.2 && < 0.4@containers >= 0.1 \&\& < 0.4@g' \
	    -e 's@array      >= 0.2 && < 0.4@array      >= 0.1 \&\& < 0.4@g' \
	    "${S}/${PN}.cabal"
}
