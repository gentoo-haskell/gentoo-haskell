# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib haddock"
inherit darcs haskell-cabal

DESCRIPTION="A Haskell library for linear algebra and numerical computations based on the GSL"
HOMEPAGE="http://dis.um.es/~alberto/GSLHaskell/"
EDARCS_REPOSITORY="http://dis.um.es/~alberto/GSLHaskell/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.4
	>=sci-libs/gsl-1.4
	virtual/lapack"

S="${WORKDIR}/${P}/src"
