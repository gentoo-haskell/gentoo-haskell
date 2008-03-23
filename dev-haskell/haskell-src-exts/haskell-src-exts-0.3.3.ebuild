# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib happy"
inherit base haskell-cabal eutils versionator

DESCRIPTION="An extension to haskell-src that handles most common syntactic extensions to Haskell"
HOMEPAGE="http://code.haskell.org/HSP/haskell-src-exts/"
SRC_URI="http://hackage.haskell.org/packages/archive/haskell-src-exts/0.3.3/haskell-src-exts-0.3.3.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.2
		dev-haskell/happy"

#S=${WORKDIR}/haskell-src-exts/src/haskell-src-exts

src_unpack() {
	base_src_unpack

	# Make it work with ghc 6.6
    #cd "${S}"
	#epatch "${FILESDIR}/${PN}-0.2-hiding-isSymbol.patch"

	# Make it work with ghc pre-6.4
	#sed -i 's/{-# OPTIONS_GHC /{-# OPTIONS /' \
	#	"${S}/Language/Haskell/Exts/Syntax.hs" \
	#	"${S}/Language/Haskell/Exts/Pretty.hs"
	#sed -i 's/#ifdef __GLASGOW_HASKELL__/#if __GLASGOW_HASKELL__>=604/' \
	#	"${S}/Language/Haskell/Exts/Syntax.hs"

	#if version_is_at_least "6.8" "$(ghc-version)"; then
	#	sed -i -e '/Build-Depends:/a \
	#		, array, pretty' \
	#	"${S}/${PN}.cabal"
	#fi

}
