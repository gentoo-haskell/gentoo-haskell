# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit base haskell-cabal

MY_PN="OpenAL"
GHC_PV=6.5.20060910

DESCRIPTION="A Haskell binding to the OpenAL cross-platform 3D audio API"
HOMEPAGE=""
SRC_URI="http://www.haskell.org/ghc/dist/current/dist/ghc-${GHC_PV}-src-extralibs.tar.bz2"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="=virtual/ghc-6.5*
	dev-haskell/opengl
	media-libs/openal"

S="${WORKDIR}/ghc-${GHC_PV}/libraries/${MY_PN}"

#TODO: install examples perhaps?
