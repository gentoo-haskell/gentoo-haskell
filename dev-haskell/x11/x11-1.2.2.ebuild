# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN=X11
MY_P=${MY_PN}-${PV}

DESCRIPTION="X11 bindings for haskell"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=virtual/ghc-6.4"
# tested with ghc-6.6 and ghc-6.6.1. probably works with ghc-6.4 too

S="${WORKDIR}/${MY_P}"
