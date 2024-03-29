# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Semi-automatic database schema migrations"
HOMEPAGE="https://github.com/tdammers/migrant"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="dev-haskell/migrant-core:=[profile?]
	>=dev-haskell/sqlite-simple-0.4.18.0:=[profile?] <dev-haskell/sqlite-simple-0.5:=[profile?]
	>=dev-haskell/text-1.2:=[profile?] <dev-haskell/text-3:=[profile?]
	>=dev-lang/ghc-8.8.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.0.0.0
	test? ( >=dev-haskell/hunit-1.6.1.0 <dev-haskell/hunit-1.7
		>=dev-haskell/quickcheck-2.14.2 <dev-haskell/quickcheck-2.15
		>=dev-haskell/tasty-1.4 <dev-haskell/tasty-1.5
		>=dev-haskell/tasty-hunit-0.10.0.2 <dev-haskell/tasty-hunit-0.11
		>=dev-haskell/tasty-quickcheck-0.10.1.1 <dev-haskell/tasty-quickcheck-0.11 )
"
