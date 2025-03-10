# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999

CABAL_HACKAGE_REVISION=2
CABAL_PN="Chart"

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A library for generating 2D Charts and Plots"
HOMEPAGE="https://github.com/timbod7/haskell-chart/wiki"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/colour-2.2.1:=[profile?] <dev-haskell/colour-2.4:=[profile?]
	<dev-haskell/data-default-class-0.3:=[profile?]
	>=dev-haskell/lens-3.9:=[profile?] <dev-haskell/lens-5.4:=[profile?]
	dev-haskell/old-locale:=[profile?]
	>=dev-haskell/operational-0.2.2:=[profile?] <dev-haskell/operational-0.3:=[profile?]
	>=dev-haskell/vector-0.9:=[profile?] <dev-haskell/vector-0.14:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
"
