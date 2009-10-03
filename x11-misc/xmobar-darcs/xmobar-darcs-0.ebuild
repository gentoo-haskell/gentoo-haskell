# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"
inherit haskell-cabal darcs

DESCRIPTION="A Minimalistic Text Based Status Bar"
HOMEPAGE="http://gorgias.mine.nu/xmobar/"
EDARCS_REPOSITORY="http://code.haskell.org/xmobar"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 -sparc ~x86"

IUSE="xft unicode mail"

DEPEND=">=dev-lang/ghc-6.6.1
	dev-haskell/bytestring
	>=dev-haskell/cabal-1.2
	|| ( >=dev-haskell/x11-1.3.0 dev-haskell/x11-darcs )
	>=dev-haskell/mtl-1.0
	>=dev-haskell/filepath-1.0
	dev-haskell/parsec
	dev-haskell/stm
	dev-haskell/action-permutations
	unicode? ( dev-haskell/utf8-string )
	xft?  ( dev-haskell/utf8-string
			dev-haskell/x11-xft )
	mail? ( dev-haskell/hinotify )
	!x11-misc/xmobar"
RDEPEND="${DEPEND}"

src_compile() {
	if use xft; then
		CABAL_CONFIGURE_FLAGS="--flags=with_xft"
	else
		CABAL_CONFIGURE_FLAGS="--flags=-with_xft"
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
