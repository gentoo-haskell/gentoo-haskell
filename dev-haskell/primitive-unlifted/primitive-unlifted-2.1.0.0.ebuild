# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.5.1.9999

CABAL_HACKAGE_REVISION=1

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Primitive GHC types with unlifted types inside"
HOMEPAGE="https://github.com/haskell-primitive/primitive-unlifted"

LICENSE="BSD"
SLOT="0/${PV}"
#KEYWORDS="~amd64" # Keep in sync with ghc-9.4

RDEPEND=">=dev-haskell/primitive-0.7:=[profile?] <dev-haskell/primitive-0.10:=[profile?]
	>=dev-haskell/text-short-0.1.3:=[profile?] <dev-haskell/text-short-0.2:=[profile?]
	>=dev-lang/ghc-9.4.5:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.8.1.0
	test? ( dev-haskell/quickcheck
		dev-haskell/quickcheck-classes-base
		dev-haskell/tasty
		dev-haskell/tasty-quickcheck )
"
