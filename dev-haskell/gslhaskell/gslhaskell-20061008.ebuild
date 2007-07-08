# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib"
inherit haskell-cabal

MY_PN=GSLHaskell
MY_PV="2006-10-08"
MY_P=${MY_PN}-${MY_PV}

DESCRIPTION="Haskell interface to the GNU Scientific Library"
HOMEPAGE="http://dis.um.es/~alberto/GSLHaskell/"
SRC_URI="http://dis.um.es/~alberto/GSLHaskell/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
	dev-haskell/hgl
	dev-haskell/opengl
	dev-haskell/glut
	dev-haskell/hunit
	dev-haskell/x11
	>=sci-libs/gsl-1.5"

S=${WORKDIR}/${MY_P}
