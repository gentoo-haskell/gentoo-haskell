# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"
CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Linear algebra and numerical computation"
HOMEPAGE="http://code.haskell.org/hmatrix"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mkl vector"

RDEPEND=">=dev-lang/ghc-6.10.1
		dev-haskell/storable-complex
		mkl? ( sci-libs/mkl )
		vector? ( >=dev-haskell/vector-0.7 )"
DEPEND=">=dev-haskell/cabal-1.6
		${RDEPEND}"

src_configure() {
	cabal_src_configure \
		--flags=-tests \
		$(cabal_flag mkl) \
		$(cabal_flag vector)
}
