# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit base haskell-cabal

MY_PN="Raincat"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A puzzle game written in Haskell with a cat in lead role"
HOMEPAGE="http://raincat.bysusanlin.com/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libsdl
		media-libs/sdl-image
		media-libs/sdl-mixer
		virtual/glut
		virtual/opengl"

DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		>=dev-lang/ghc-6.8
		dev-haskell/extensible-exceptions
		dev-haskell/glut
		dev-haskell/mtl
		dev-haskell/opengl
		dev-haskell/sdl
		dev-haskell/sdl-image
		dev-haskell/sdl-mixer
		dev-haskell/time"

S="${WORKDIR}/${MY_P}"
PATCHES=("${FILESDIR}/0001-fixed-build-failure-Main-did-not-exported-main.patch")
