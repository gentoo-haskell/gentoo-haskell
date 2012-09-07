# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit base haskell-cabal

DESCRIPTION="Actors with multi-headed receive clauses"
HOMEPAGE="http://sulzmann.blogspot.com/2008/10/actors-with-multi-headed-receive.html"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		dev-haskell/stm
		dev-haskell/time"

src_unpack() {
	base_src_unpack

	sed -e 's/base/base < 4/' -i "${S}/${PN}.cabal"
}
