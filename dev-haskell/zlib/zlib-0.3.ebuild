# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Compression and decompression in the gzip and zlib formats"
HOMEPAGE="http://www.haskell.org/~duncan/zlib/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${P}.tar.gz"

LICENSE="BSD3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# works with ghc 6.4 too, but needs the fps package:
# 1) in DEPEND
# 2) in zlib.cabal

DEPEND=">=virtual/ghc-6.6
	>=sys-libs/zlib-1.2"
