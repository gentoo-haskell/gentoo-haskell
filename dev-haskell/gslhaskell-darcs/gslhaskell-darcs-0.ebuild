# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib"
inherit base darcs haskell-cabal

DESCRIPTION="A Haskell library for linear algebra and numerical computations based on the GSL"
HOMEPAGE="http://dis.um.es/~alberto/GSLHaskell/"
LICENSE="GPL-style" # whatever that means
SLOT="${PV}"

KEYWORDS="~amd64"
IUSE=""

DEPEND=">=virtual/ghc-6.4"

EDARCS_REPOSITORY="http://dis.um.es/~alberto/GSLHaskell"
EDARCS_GET_CMD="get --partial"

S="$S"/src

