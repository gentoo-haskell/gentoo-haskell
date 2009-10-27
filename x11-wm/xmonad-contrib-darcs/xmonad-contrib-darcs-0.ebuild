# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock hscolour"

inherit haskell-cabal darcs

DESCRIPTION="Third party extensions for xmonad"
HOMEPAGE="http://www.xmonad.org/"
EDARCS_REPOSITORY="http://code.haskell.org/XMonadContrib"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="xft"

DEPEND="dev-haskell/mtl
	x11-wm/xmonad-darcs
	>=dev-lang/ghc-6.6
	dev-haskell/x11-darcs
	xft?  ( dev-haskell/x11-xft )"
RDEPEND="${DEPEND}"

src_compile() {
	CABAL_CONFIGURE_FLAGS="--flags=-testing"

	if use xft; then
		CABAL_CONFIGURE_FLAGS="${CABAL_CONFIGURE_FLAGS} --flags=use_xft"
	else
		CABAL_CONFIGURE_FLAGS="${CABAL_CONFIGURE_FLAGS} --flags=-use_xft"
	fi

	cabal_src_compile
}
