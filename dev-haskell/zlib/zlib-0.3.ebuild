# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Compression and decompression in the gzip and zlib formats"
HOMEPAGE="http://www.haskell.org/~duncan/zlib/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PN}-${PV}.tar.gz"

LICENSE="BSD3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.6
	>=sys-libs/zlib-1.2"

S="${WORKDIR}/${PN}-${PV}"
