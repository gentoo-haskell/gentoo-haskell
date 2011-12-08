# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="Pure Haskell loader for PNG images"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/pngload"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2.1
		dev-haskell/mtl
		>=dev-haskell/parsec-3.0.0
		dev-haskell/zlib"
