# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

WX_GTK_VER="2.8"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit base haskell-cabal wxwidgets

DESCRIPTION="wxHaskell core"
HOMEPAGE="http://haskell.org/haskellwiki/WxHaskell"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="wxWinLL-3.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="opengl"

RDEPEND="dev-haskell/parsec
		dev-haskell/stm
		dev-haskell/time
		>=dev-haskell/wxdirect-0.13.1.1
		>=dev-lang/ghc-6.10.1
		x11-libs/wxGTK:2.8[X,gstreamer,opengl?]"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

PATCHES=("${FILESDIR}/${PN}-0.13.2-ghc-7.4.patch")
