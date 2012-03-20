# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal darcs

DESCRIPTION="Third party extensions for xmonad with wacky dependencies"
HOMEPAGE="http://projects.haskell.org/xmonad-extras"
EDARCS_REPOSITORY="http://code.haskell.org/xmonad-extras/"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="volume eval mpd"

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2.1
		dev-haskell/mtl
		>=dev-haskell/x11-1.4.3
		=x11-wm/xmonad-9999
		=x11-wm/xmonad-contrib-9999
		volume? ( dev-haskell/parsec dev-haskell/split media-sound/alsa-utils )
		eval? ( dev-haskell/network dev-haskell/hint )
		mpd? ( =dev-haskell/libmpd-0.5* )"

src_compile() {
	CABAL_CONFIGURE_FLAGS="--flags=-testing"

	if use volume; then
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=with_parsec --flags=with_split"
	else
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=-with_parsec --flags=-with_split"
	fi

	if use eval; then
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=with_hint"
	else
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=-with_hint"
	fi

	if use mpd; then
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=with_mpd"
	else
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=-with_mpd"
	fi

	cabal_src_compile
}
