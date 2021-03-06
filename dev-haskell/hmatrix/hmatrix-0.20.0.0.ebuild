# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.3

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Numeric Linear Algebra"
HOMEPAGE="https://github.com/albertoruiz/hmatrix"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/random:=[profile?]
	dev-haskell/semigroups:=[profile?]
	dev-haskell/split:=[profile?]
	dev-haskell/storable-complex:=[profile?]
	>=dev-haskell/vector-0.11:=[profile?]
	>=dev-lang/ghc-8.0.1:=
	virtual/blas
	virtual/lapack
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.24.0.0
"

PATCHES=( "${FILESDIR}"/${PN}-0.20.0.0-gentoo-blas.patch )
