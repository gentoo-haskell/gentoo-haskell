# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib happy"
inherit base haskell-cabal

DESCRIPTION="An extension to haskell-src that handles most common syntactic extensions to Haskell"
HOMEPAGE="http://www.cs.chalmers.se/~d00nibro/haskell-src-exts/"
SRC_URI="http://www.cs.chalmers.se/~d00nibro/haskell-src-exts/haskell-src-exts-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/ghc"

S=${WORKDIR}/haskell-src-exts/src/haskell-src-exts

src_unpack() {
	base_src_unpack

	# Make it work with ghc 6.6
	epatch "${FILESDIR}/${P}-hiding-isSymbol.patch"

	# Make it work with ghc pre-6.4
	sed -i 's/{-# OPTIONS_GHC /{-# OPTIONS /' \
		${S}/Language/Haskell/Hsx/Syntax.hs \
		${S}/Language/Haskell/Hsx/Pretty.hs
	sed -i 's/#ifdef __GLASGOW_HASKELL__/#if __GLASGOW_HASKELL__>=604/' \
		${S}/Language/Haskell/Hsx/Syntax.hs
}
