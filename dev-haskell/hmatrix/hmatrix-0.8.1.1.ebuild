# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Linear algebra and numerical computations"
HOMEPAGE="http://www.hmatrix.googlepages.com"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		 dev-haskell/hunit
		 dev-haskell/quickcheck
		 dev-haskell/storable-complex
		 sci-libs/gsl
		 virtual/blas
		 virtual/lapack"
DEPEND=">=dev-haskell/cabal-1.2
		${RDEPEND}"
