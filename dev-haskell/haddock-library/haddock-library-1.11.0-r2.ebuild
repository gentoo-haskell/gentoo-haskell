# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.5.1.9999

CABAL_HACKAGE_REVISION=3

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Library exposing some functionality of Haddock"
HOMEPAGE="https://www.haskell.org/haddock/"

LICENSE="BSD-2"
SLOT="0/${PV}"
# Keep in sync with ghc-9.4
#KEYWORDS="~amd64 ~amd64-linux"

RDEPEND="
	>=dev-haskell/parsec-3.1.13.0:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-lang/ghc-9.0.2:=
	|| (
		( >=dev-haskell/text-1.2.3.0 <dev-haskell/text-1.3 )
		( >=dev-haskell/text-2.0 <dev-haskell/text-2.2 )
	)
	dev-haskell/text:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? (
		>=dev-haskell/base-compat-0.12 <dev-haskell/base-compat-0.14
		>=dev-haskell/hspec-2.4.4 <dev-haskell/hspec-2.11
		>=dev-haskell/optparse-applicative-0.15
		>=dev-haskell/tree-diff-0.2 <dev-haskell/tree-diff-0.4
		|| (
			=dev-haskell/quickcheck-2.11*
			( >=dev-haskell/quickcheck-2.13.2 <dev-haskell/quickcheck-2.15 )
		)
	)
"
