# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:	$

EAPI="2"

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Iteratee-based I/O"
HOMEPAGE="http://inmachina.net/~jwlato/haskell/iteratee"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="<dev-haskell/listlike-4
		=dev-haskell/monadcatchio-transformers-0.2*
		=dev-haskell/transformers-0.2*
		>=dev-lang/ghc-6.8.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	sed -e 's@ListLike                  >= 1.0     && < 3@ListLike                  >= 1.0     \&\& < 4@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen ListLike dependency"
}
