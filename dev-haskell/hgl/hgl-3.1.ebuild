# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="HGL"
GHC_PV=6.5.20060912

DESCRIPTION="A simple graphics library based on X11 or Win32."
HOMEPAGE=""
SRC_URI="http://www.haskell.org/ghc/dist/current/dist/ghc-${GHC_PV}-src-extralibs.tar.bz2"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="=virtual/ghc-6.5*
	dev-haskell/x11"

S="${WORKDIR}/ghc-${GHC_PV}/libraries/${MY_PN}"
