# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Test interactive Haskell examples"
HOMEPAGE="https://github.com/sol/doctest#readme"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/base-compat-0.7.0:=[profile?]
	>=dev-haskell/code-page-0.1:=[profile?]
	>=dev-haskell/ghc-paths-0.1.0.9:=[profile?]
	>=dev-haskell/syb-0.3:=[profile?]
	>=dev-lang/ghc-8.0:=[profile?] <dev-lang/ghc-9.7:=[profile?]
	>=dev-lang/ghc-8.10.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.2.0.0
	test? ( >=dev-haskell/hspec-2.3.0
		>=dev-haskell/hspec-core-2.3.0
		dev-haskell/hunit
		dev-haskell/mockery
		>=dev-haskell/quickcheck-2.13.1
		dev-haskell/setenv
		>=dev-haskell/silently-1.2.4
		>=dev-haskell/stringbuilder-0.4 )
"
