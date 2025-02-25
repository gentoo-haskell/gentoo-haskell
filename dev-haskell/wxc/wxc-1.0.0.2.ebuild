# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER="3.2-gtk3"
inherit multilib wxwidgets cmake

DESCRIPTION="wxHaskell C++ wrapper"
HOMEPAGE="https://codeberg.org/wxHaskell/wxHaskell/src/branch/master/wxc"
SRC_URI="https://codeberg.org/wxHaskell/wxHaskell/archive/wxc-1.0.0.2.tar.gz"
S="${WORKDIR}/wxhaskell/wxc"
PATCHES=(
	"${FILESDIR}"/${P}-missing_headers.patch
	)

LICENSE="wxWinLL-3.1"
SLOT="${WX_GTK_VER}/${PV}"
KEYWORDS="~amd64"
IUSE="gstreamer"

DEPEND="${RDEPEND}"
RDEPEND="x11-libs/wxGTK:${WX_GTK_VER}=[X,gstreamer?,opengl]
	!!dev-haskell/wxc:3.2"
