# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour"
inherit base haskell-cabal

DESCRIPTION="Linear algebra and numerical computation"
HOMEPAGE="http://perception.inf.um.es/hmatrix"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="binary mkl test vector"

RDEPEND=">=dev-lang/ghc-6.10.1
		dev-haskell/storable-complex
		binary? ( dev-haskell/binary )
		mkl? ( sci-libs/mkl )
		vector? ( >=dev-haskell/vector-0.7 )
		test? ( dev-haskell/hunit
			dev-haskell/quickcheck )
		sci-libs/gsl
		virtual/blas
		virtual/lapack"

DEPEND=">=dev-haskell/cabal-1.6
		${RDEPEND}"

PATCHES=("${FILESDIR}/${P}-vector-0.8.patch")

# tests don't do what you expect and should be fixed,
# but I intentionally left them here --slyfox
src_configure() {
	cabal_src_configure \
		$(cabal_flag binary) \
		$(cabal_flag mkl) \
		$(cabal_flag test tests) \
		$(cabal_flag vector)
}
