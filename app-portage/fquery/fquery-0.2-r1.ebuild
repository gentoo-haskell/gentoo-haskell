# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

CABAL_FEATURES="bin"

inherit base eutils haskell-cabal

DESCRIPTION="A fast replacement for equery"
HOMEPAGE="http://home.exetel.com.au/tjaden/fquery/"
SRC_URI="http://home.exetel.com.au/tjaden/fquery/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4"

# Fix 'Text.Regex' hidden error
PATCHES=("${FILESDIR}/cabal-fix.patch")
