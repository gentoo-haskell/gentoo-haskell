# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Compression and decompression in the gzip and zlib formats"
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

# works with ghc 6.4 too, but needs the fps package:
# 1) in DEPEND
# 2) in zlib.cabal

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2.1
        >=sys-libs/zlib-1.2"
