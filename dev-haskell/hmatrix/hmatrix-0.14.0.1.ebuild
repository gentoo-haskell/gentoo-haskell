# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="Linear algebra and numerical computation"
HOMEPAGE="https://github.com/albertoruiz/hmatrix"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+dd mkl unsafe finit debugfpu debugnan test"

RDEPEND=">=dev-lang/ghc-6.10.1
		dev-haskell/storable-complex[profile?]
		dev-haskell/binary[profile?]
		mkl? ( sci-libs/mkl )
		>=dev-haskell/vector-0.8[profile?]
		sci-libs/gsl
		virtual/blas
		virtual/lapack
	"

DEPEND=">=dev-haskell/cabal-1.8
	${RDEPEND}
	test? ( dev-haskell/hunit[profile?]
		dev-haskell/quickcheck[profile?] )
	"

# tests don't do what you expect and should be fixed,
# but I intentionally left them here --slyfox
src_configure() {
	cabal_src_configure \
		$(cabal_flag dd) \
		$(cabal_flag mkl) \
		$(cabal_flag unsafe) \
		$(cabal_flag finit) \
		$(cabal_flag debugfpu) \
		$(cabal_flag debugnan) \
		$(cabal_flag test tests)
}
