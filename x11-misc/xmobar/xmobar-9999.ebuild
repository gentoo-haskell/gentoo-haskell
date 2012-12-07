# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=4
CABAL_FEATURES="bin"
inherit eutils git-2 haskell-cabal

DESCRIPTION="A Minimalistic Text Based Status Bar"
HOMEPAGE="http://projects.haskell.org/xmobar/"
EGIT_REPO_URI="git://github.com/jaor/xmobar.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="xft unicode mail mpd mpris alsa timezone wifi"

RDEPEND="x11-libs/libXrandr
	wifi? ( net-wireless/wireless-tools )
	"

DEPEND="${RDEPEND}
		>=dev-lang/ghc-7.0.1
		>=dev-haskell/cabal-1.6
		>=dev-haskell/mtl-2.0 <dev-haskell/mtl-2.2
		>=dev-haskell/parsec-3
		>=dev-haskell/stm-2.3 <dev-haskell/stm-2.5
		=dev-haskell/x11-1.6*
		xft?  ( =dev-haskell/utf8-string-0.3*
			=dev-haskell/x11-xft-0.3*
		)
		mail? ( =dev-haskell/hinotify-0.3* )
		mpd? ( =dev-haskell/libmpd-0.7* )
		alsa? ( =dev-haskell/alsa-mixer-0.1*
			=dev-haskell/alsa-core-0.5*
		)
		timezone? ( =dev-haskell/timezone-series-0.1*
			=dev-haskell/timezone-olson-0.1*
		)
		mpris? ( >=dev-haskell/dbus-core-0.9.2.1
			>=dev-haskell/text-0.11.1.5 <dev-haskell/text-0.12
		)
		"

RDEPEND+="mpd? ( media-sound/mpd )"

src_configure() {
	# with_threaded is to workaround http://hackage.haskell.org/trac/ghc/ticket/4934
	# but it's broken in current master:
	#    https://github.com/jaor/xmobar/issues/77
	cabal_src_configure \
		--flags=-with_threaded \
		$(cabal_flag xft with_xft) \
		$(cabal_flag unicode with_utf8) \
		$(cabal_flag mail with_inotify) \
		$(cabal_flag mpd with_mpd) \
		$(cabal_flag alsa with_alsa) \
		$(cabal_flag timezone with_datezone) \
		$(cabal_flag wifi with_iwlib)
}

src_install() {
	cabal_src_install

	dodoc samples/xmobar.config readme.md news.md
}
