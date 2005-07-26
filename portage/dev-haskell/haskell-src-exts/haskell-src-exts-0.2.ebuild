# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="haddock"
inherit haskell-cabal

DESCRIPTION="An extension to haskell-src that handles most common syntactic extensions to Haskell"
HOMEPAGE="http://www.cs.chalmers.se/~d00nibro/haskell-src-exts/"
SRC_URI="http://www.cs.chalmers.se/~d00nibro/haskell-src-exts/haskell-src-exts-${PV}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/ghc
	=dev-haskell/harp-${PV}"

S=${WORKDIR}/haskell-src-exts/src/haskell-src-exts

