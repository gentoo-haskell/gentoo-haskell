# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile happy"
inherit base haskell-cabal eutils versionator

DESCRIPTION="An extension to haskell-src that handles most common syntactic extensions to Haskell"
HOMEPAGE="http://www.cs.chalmers.se/~d00nibro/haskell-src-exts/"
SRC_URI="http://www.cs.chalmers.se/~d00nibro/haskell-src-exts/haskell-src-exts-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.2
		dev-haskell/happy"

S=${WORKDIR}/haskell-src-exts/src/haskell-src-exts

src_unpack() {
	base_src_unpack

	# Make it work with ghc 6.6
	cd "${S}"
	epatch "${FILESDIR}/${P}-hiding-isSymbol.patch"

	# Make it work with ghc pre-6.4
	sed -i 's/{-# OPTIONS_GHC /{-# OPTIONS /' \
		"${S}/Language/Haskell/Hsx/Syntax.hs" \
		"${S}/Language/Haskell/Hsx/Pretty.hs"
	sed -i 's/#ifdef __GLASGOW_HASKELL__/#if __GLASGOW_HASKELL__>=604/' \
		"${S}/Language/Haskell/Hsx/Syntax.hs"

	if version_is_at_least "6.8" "$(ghc-version)"; then
		sed -i -e '/Build-Depends:/a \
			, array, pretty' \
		"${S}/${PN}.cabal"
	fi

}
