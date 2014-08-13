# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=5

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit darcs haskell-cabal

DESCRIPTION="Third party extensions for xmonad with wacky dependencies"
HOMEPAGE="http://projects.haskell.org/xmonad-extras"
EDARCS_REPOSITORY="http://code.haskell.org/xmonad-extras/"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="+eval mpd perwindow volume"

RDEPEND="dev-haskell/mtl:=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/regex-posix:=[profile?]
	>=dev-haskell/x11-1.4.3:=[profile?]
	>=dev-lang/ghc-6.10.4:=
	>=x11-wm/xmonad-0.10:=[profile?] <x11-wm/xmonad-0.13:=[profile?]
	>=x11-wm/xmonad-contrib-0.10:=[profile?] <x11-wm/xmonad-contrib-0.13:=[profile?]
	eval? ( >=dev-haskell/hint-0.3:=[profile?] <dev-haskell/hint-0.5:=[profile?]
			dev-haskell/network:=[profile?] )
	mpd? ( >=dev-haskell/libmpd-0.8:=[profile?] <dev-haskell/libmpd-0.9:=[profile?] )
	perwindow? ( >=dev-haskell/hlist-0.2.3 <dev-haskell/hlist-0.3 )
	volume? ( >=dev-haskell/parsec-2:=[profile?] <dev-haskell/parsec-4:=[profile?]
			>=dev-haskell/split-0.1:=[profile?] <dev-haskell/split-0.3:=[profile?] )
"

DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6.0.3
"

src_configure() {
	cabal_src_configure \
		--flags=-testing \
		$(cabal_flag eval with_hint) \
		$(cabal_flag mpd with_mpd) \
		$(cabal_flag perwindow with_template_haskell) \
		$(cabal_flag perwindow with_hlist) \
		$(cabal_flag volume with_parsec) $(cabal_flag volume with_split)
}
