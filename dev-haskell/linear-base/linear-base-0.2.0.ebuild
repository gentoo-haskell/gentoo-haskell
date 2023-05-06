# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.3.0

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Standard library for linear types"
HOMEPAGE="https://github.com/tweag/linear-base#README"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="dev-haskell/hashable:=[profile?]
	>=dev-haskell/linear-generics-0.2:=[profile?]
	dev-haskell/primitive:=[profile?]
	dev-haskell/storable-tuple:=[profile?]
	>=dev-haskell/vector-0.12.2:=[profile?]
	>=dev-lang/ghc-9.0.2:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? ( dev-haskell/hedgehog
		dev-haskell/inspection-testing
		dev-haskell/mmorph
		dev-haskell/tasty
		dev-haskell/tasty-hedgehog
		dev-haskell/tasty-inspection-testing )
"
