# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Snap backend for the digestive-functors library"
HOMEPAGE="http://github.com/jaspervdj/digestive-functors"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/blaze-html-0.3
		=dev-haskell/digestive-functors-0.0.2*
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare () {
	sed -e 's@blaze-html >= 0.3 && < 0.4@blaze-html >= 0.3 \&\& < 0.5@' \
		-i "${S}/${PN}.cabal"
}
