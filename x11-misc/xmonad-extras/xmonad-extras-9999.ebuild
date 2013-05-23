# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal darcs

DESCRIPTION="Third party extensions for xmonad with wacky dependencies"
HOMEPAGE="http://projects.haskell.org/xmonad-extras"
EDARCS_REPOSITORY="http://code.haskell.org/xmonad-extras/"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="volume eval mpd perwindow"

RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/mtl
		dev-haskell/network
		dev-haskell/regex-posix
		>=dev-haskell/x11-1.4.3
		=x11-wm/xmonad-9999
		=x11-wm/xmonad-contrib-9999
		volume? ( <dev-haskell/parsec-4 dev-haskell/split media-sound/alsa-utils )
		eval? ( =dev-haskell/hint-0.3* )
		mpd? ( =dev-haskell/libmpd-0.8* )
		perwindow? ( >=dev-haskell/hlist-0.2.3
		  <dev-haskell/hlist-0.3 )
		"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.1"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-alt-config.patch
}

src_configure() {
	cabal_src_configure \
		--flags=-testing \
		$(cabal_flag volume with_parsec) $(cabal_flag volume with_split) \
		$(cabal_flag eval with_hint) \
		$(cabal_flag mpd with_mpd) \
		$(cabal_flag perwindow with_template_haskell) \
		$(cabal_flag perwindow with_hlist)
}
