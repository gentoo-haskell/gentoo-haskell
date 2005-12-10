# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit base haskell-cabal

DESCRIPTION="An extension to haskell-src that handles most common syntactic extensions to Haskell"
HOMEPAGE="http://www.cs.chalmers.se/~d00nibro/haskell-src-exts/"
SRC_URI="http://www.cs.chalmers.se/~d00nibro/haskell-src-exts/haskell-src-exts-${PV}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/ghc
	=dev-haskell/harp-${PV}
	dev-haskell/happy"

S=${WORKDIR}/haskell-src-exts/src/haskell-src-exts

src_unpack() {
	base_src_unpack

	# Make it work with ghc pre-6.4
	sed -i 's/{-# OPTIONS_GHC /{-# OPTIONS /' \
		${S}/Language/Haskell/Hsx/Syntax.hs \
		${S}/Language/Haskell/Hsx/Pretty.hs
	sed -i 's/#ifdef __GLASGOW_HASKELL__/#if __GLASGOW_HASKELL__>=604/' \
		${S}/Language/Haskell/Hsx/Syntax.hs
}
