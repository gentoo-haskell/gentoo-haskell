# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal eutils

DESCRIPTION="A Minimalistic Text Based Status Bar"
HOMEPAGE="http://code.haskell.org/~arossato/xmobar"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xft unicode mail"

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6
		dev-haskell/bytestring
		>=dev-haskell/x11-1.3.0
		dev-haskell/mtl
		dev-haskell/parsec
		dev-haskell/filepath
		dev-haskell/stm
		mail? ( dev-haskell/hinotify )
        unicode? ( dev-haskell/utf8-string )
        xft?  ( dev-haskell/utf8-string
                dev-haskell/x11-xft )"

src_compile() {
	CABAL_CONFIGURE_FLAGS="--constraint=base<4"

	if use xft; then
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=with_xft"
	else
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=-with_xft"
	fi

	if use unicode; then
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=with_utf8"
	else
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=-with_utf8"
	fi

	if use mail; then
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=with_inotify"
	else
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=-with_inotify"
	fi

	cabal_src_compile
}

src_install() {
	cabal_src_install

	dodoc xmobar.config-sample README
}
