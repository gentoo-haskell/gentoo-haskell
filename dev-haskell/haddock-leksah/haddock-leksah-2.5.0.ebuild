# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=2

#haddock fails to generate it's docs! so to doc related flags
#src/Haddock/Interface/Create.hs:517:14:
#    The last statement in a 'do' construct must be an expression
CABAL_FEATURES="bin lib profile"
inherit haskell-cabal

DESCRIPTION="A documentation-generation tool for Haskell libraries"
HOMEPAGE="http://www.haskell.org/haddock/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10
		>=dev-haskell/cabal-1.6
		dev-haskell/ghc-paths"

src_prepare() {
		# avoiding haddock collision
		sed -i 's/executable haddock/executable haddock-leksah/' "${S}/${PN}.cabal"
}
