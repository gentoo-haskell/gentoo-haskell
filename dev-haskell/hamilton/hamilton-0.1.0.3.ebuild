# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Physics on generalized coordinate systems using Hamiltonian Mechanics and AD"
HOMEPAGE="https://github.com/mstksg/hamilton#readme"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/ad:=[profile?]
	dev-haskell/ansi-wl-pprint:=[profile?]
	dev-haskell/finite-typelits:=[profile?]
	dev-haskell/ghc-typelits-knownnat:=[profile?]
	>=dev-haskell/hmatrix-0.18:=[profile?]
	>=dev-haskell/hmatrix-gsl-0.18:=[profile?]
	dev-haskell/hmatrix-vector-sized:=[profile?]
	>=dev-haskell/optparse-applicative-0.13:=[profile?]
	>=dev-haskell/typelits-witnesses-0.2.3:=[profile?]
	dev-haskell/vector:=[profile?]
	>=dev-haskell/vector-sized-1.0:=[profile?]
	dev-haskell/vty:=[profile?]
	>=dev-lang/ghc-8.0.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.24.0.0
"
