# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN=X11

DESCRIPTION="X11 bindings for haskell"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI="http://hackage.haskell.org/packages/archive/X11/${PV}/${MY_PN}-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=virtual/ghc-6.6.1"

S="${WORKDIR}/${MY_PN}-${PV}"
