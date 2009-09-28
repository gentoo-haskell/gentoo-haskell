# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock hscolour"

inherit haskell-cabal darcs

DESCRIPTION="Third party extentions for xmonad"
HOMEPAGE="http://www.xmonad.org/"
EDARCS_REPOSITORY="http://code.haskell.org/XMonadContrib"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="xft unicode"

DEPEND=">=dev-haskell/mtl-1.0
	x11-wm/xmonad-darcs
	>=dev-lang/ghc-6.6
	dev-haskell/x11-darcs
	unicode? ( dev-haskell/utf8-string )
	xft?  ( dev-haskell/utf8-string
			dev-haskell/x11-xft )"
RDEPEND="${DEPEND}"

src_compile() {
	CABAL_CONFIGURE_FLAGS=""

	if use xft; then
		CABAL_CONFIGURE_FLAGS="--flags=use_xft"
	else
		CABAL_CONFIGURE_FLAGS="--flags=-use_xft"
	fi

	if use unicode; then
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=with_utf8"
	else
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=-with_utf8"
	fi
	cabal_src_compile
}
