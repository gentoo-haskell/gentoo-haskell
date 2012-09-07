# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Dynamic linking for Haskell and C objects"
HOMEPAGE="http://code.haskell.org/~dons/code/hs-plugins"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10
		>=dev-haskell/cabal-1.6
		dev-haskell/haskell-src"

src_unpack() {
	unpack ${A}

	# haddock parse error
	sed -e "s/| strip/strip/" -i "${S}/src/System/Plugins/Env.hs"
}
