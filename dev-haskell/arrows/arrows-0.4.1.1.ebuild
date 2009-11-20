# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Arrow classes and transformers"
HOMEPAGE="http://www.haskell.org/arrows/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10
		dev-haskell/cabal
		dev-haskell/stream"

src_unpack() {
	unpack ${A}

	# ghc-6.12 future proof
	sed 's@base >= 4.0 \&\& < 4.2@base >= 4.0 \&\& < 4.3@g' \
	    -i "${S}/${PN}.cabal"
}
