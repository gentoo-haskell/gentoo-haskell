# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

WX_GTK_VER="2.8"

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit base haskell-cabal wxwidgets

DESCRIPTION="wxHaskell core"
HOMEPAGE="http://haskell.org/haskellwiki/WxHaskell"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="wxWinLL-3.1"
SLOT="${WX_GTK_VER}/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="opengl"

RDEPEND="dev-haskell/parsec:=[profile?]
		dev-haskell/stm:=[profile?]
		dev-haskell/time:=[profile?]
		>dev-haskell/wxdirect-0.12.1.2:${WX_GTK_VER}=[profile?]
		>=dev-lang/ghc-6.10.4:=
		x11-libs/wxGTK:${WX_GTK_VER}=[X,gstreamer,opengl?]"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

PATCHES=("${FILESDIR}/${PN}-0.13.2.1-ghc-7.6.patch")

src_prepare() {
	base_src_prepare
	sed -e "s@wxdirect@wxdirect-${WX_GTK_VER}@g" \
		-i "${S}/Setup.hs" \
		|| die "Could not change Setup.hs for wxdirect slot ${WX_GTK_VER}"
}
