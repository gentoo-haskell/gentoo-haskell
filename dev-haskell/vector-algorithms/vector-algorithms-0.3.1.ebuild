# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Efficient algorithms for vector arrays"
HOMEPAGE="http://code.haskell.org/~dolio/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.1
		>=dev-haskell/primitive-0.2
		>=dev-haskell/vector-0.5"
DEPEND=">=dev-haskell/cabal-1.2.3
		${RDEPEND}"

src_unpack() {
	unpack ${A}

	# Remove upper bounds on vector and primitive dep
	sed -i -e "s/vector >= 0.5 && < 0.6, primitive >=0.2 && <0.3/vector >= 0.5, primitive >=0.2/" \
		"${S}/${PN}.cabal"
}
