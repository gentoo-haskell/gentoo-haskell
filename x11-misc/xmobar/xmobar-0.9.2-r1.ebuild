# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xmobar/xmobar-0.9.2-r1.ebuild,v 1.3 2010/01/27 19:13:26 kolmodin Exp $

CABAL_FEATURES="bin"
inherit base haskell-cabal

DESCRIPTION="A Minimalistic Text Based Status Bar"
HOMEPAGE="http://code.haskell.org/~arossato/xmobar"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 -sparc ~x86"
IUSE="xft unicode mail"

RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/mtl
		dev-haskell/parsec
		dev-haskell/stm
		unicode? ( dev-haskell/utf8-string )
		xft?  ( dev-haskell/utf8-string
				dev-haskell/x11-xft )
		mail? ( dev-haskell/hinotify )"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

PATCHES=("${FILESDIR}/${P}-cpu-high-load.patch")

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
