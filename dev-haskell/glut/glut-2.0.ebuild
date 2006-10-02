# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib"
inherit haskell-cabal

MY_PN=GLUT
GHC_PV=6.5.20061001

DESCRIPTION="GLUT bindings for haskell"
HOMEPAGE="http://www.haskell.org/HOpenGL/"
SRC_URI="http://www.haskell.org/ghc/dist/current/dist/ghc-${GHC_PV}-src-extralibs.tar.bz2"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86 ~amd64"

# TODO: Install examples when the "examples" USE flag is set
IUSE=""

DEPEND="=virtual/ghc-6.5*
	dev-haskell/opengl
	virtual/glu
	virtual/glut"

S="${WORKDIR}/ghc-${GHC_PV}/libraries/${MY_PN}"
