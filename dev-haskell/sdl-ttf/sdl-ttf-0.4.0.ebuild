# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal

MY_PN="SDL-ttf"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Binding to libSDL_ttf"
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		dev-haskell/sdl
		media-libs/sdl-ttf"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"

	sed -i -e "s|Include-Dirs: .|Include-Dirs: . /usr/include/SDL|" \
		"${S}/SDL-ttf.cabal"
}
