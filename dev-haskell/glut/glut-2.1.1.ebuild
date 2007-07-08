# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="haddock lib profile"
inherit haskell-cabal

MY_PN=GLUT
GHC_PV=6.6.1

DESCRIPTION="GLUT bindings for haskell"
HOMEPAGE="http://www.haskell.org/HOpenGL/"
SRC_URI="http://www.haskell.org/ghc/dist/${GHC_PV}/ghc-${GHC_PV}-src-extralibs.tar.bz2"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86 ~amd64"

# TODO: Install examples when the "examples" USE flag is set
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
	>=dev-haskell/opengl-2.2
	virtual/glu
	virtual/glut"

S="${WORKDIR}/ghc-${GHC_PV}/libraries/${MY_PN}"

# Sadly Setup.hs in the ghc-6.6.1 extralibs was not tested with Cabal-1.1.6.x
src_unpack() {
	unpack "${A}"
	sed -i -e "/type Hook/ s/UserHooks/Maybe UserHooks/" ${S}/Setup.hs
}
