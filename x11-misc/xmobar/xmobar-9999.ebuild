# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"
CABAL_FEATURES="bin"
inherit eutils git-2 haskell-cabal

DESCRIPTION="A Minimalistic Text Based Status Bar"
HOMEPAGE="http://projects.haskell.org/xmobar/"
EGIT_REPO_URI="git://github.com/jaor/xmobar.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="xft unicode mail mpd alsa wifi"

DEPEND=">=dev-lang/ghc-6.8.1
		>=dev-haskell/cabal-1.6
		dev-haskell/mtl
		>=dev-haskell/parsec-3
		dev-haskell/stm
		dev-haskell/time
		>=dev-haskell/x11-1.3.0
		unicode? ( dev-haskell/utf8-string )
		xft?  ( dev-haskell/utf8-string
				dev-haskell/x11-xft )
		mail? ( dev-haskell/hinotify )
		mpd? ( >=dev-haskell/libmpd-0.5 )
		alsa? ( >=dev-haskell/alsa-mixer-0.1 )
		wifi? ( net-wireless/wireless-tools )"
RDEPEND="mpd? ( media-sound/mpd )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.15-Fix-CPU-load-in-threadWaitRead.patch
}

src_configure() {
	cabal_src_configure \
		$(cabal_flag xft with_xft) \
		$(cabal_flag unicode with_utf8) \
		$(cabal_flag mail with_inotify) \
		$(cabal_flag mpd with_mpd) \
		$(cabal_flag alsa with_alsa) \
		$(cabal_flag wifi with_iwlib)
}

src_install() {
	cabal_src_install

	dodoc samples/xmobar.config README
}
