# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit base haskell-cabal

DESCRIPTION="Console and GUI interface for Google Translate service"
HOMEPAGE="http://github.com/styx/gtc"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="gui"

RDEPEND=""
DEPEND=">=dev-lang/ghc-6.12.1
	>=dev-haskell/cabal-1.8
		dev-haskell/http
		dev-haskell/json
		dev-haskell/url
		>=dev-haskell/utf8-string-0.3.6
		gui? ( dev-haskell/gtk2hs[glade] )"

PATCHES=("$FILESDIR/0001-gtg-fixup-default-search-path-for-data-.glade-file.patch")

if use gui; then
    CABAL_CONFIGURE_FLAGS="--flags=gui"
else
    CABAL_CONFIGURE_FLAGS="--flags=-gui"
fi
