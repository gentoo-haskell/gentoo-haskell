# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"

inherit eutils haskell-cabal

DESCRIPTION="A fast replacement for equery"
HOMEPAGE="http://home.exetel.com.au/tjaden/fquery/"
SRC_URI="http://home.exetel.com.au/tjaden/fquery/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.4"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Fix 'Text.Regex' hidden error
	epatch "${FILESDIR}"/cabal-fix.patch
}
