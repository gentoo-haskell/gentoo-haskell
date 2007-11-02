# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
CABAL_MIN_VERSION=1.2
inherit haskell-cabal

MY_PN="ALUT"
GHC_PV=6.8.1

DESCRIPTION="A Haskell binding for the OpenAL Utility Toolkit"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI="http://www.haskell.org/ghc/dist/${GHC_PV}/ghc-${GHC_PV}-src-extralibs.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4
	>=dev-haskell/opengl-2.2.1
	>=dev-haskell/openal-1.3.1
	media-libs/freealut"

S="${WORKDIR}/ghc-${GHC_PV}/libraries/${MY_PN}"

#TODO: install examples perhaps?
