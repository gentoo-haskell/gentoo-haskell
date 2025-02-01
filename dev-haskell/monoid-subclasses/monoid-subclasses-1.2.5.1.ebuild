# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Subclasses of Monoid"
HOMEPAGE="https://github.com/blamario/monoid-subclasses/"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/commutative-semigroups-0.1:=[profile?] <dev-haskell/commutative-semigroups-0.3:=[profile?]
	>=dev-haskell/primes-0.2:=[profile?] <dev-haskell/primes-0.3:=[profile?]
	>=dev-haskell/vector-0.12:=[profile?] <dev-haskell/vector-0.14:=[profile?]
	>=dev-lang/ghc-9.0.2:=
	|| ( ( >=dev-haskell/text-0.11:=[profile?] <dev-haskell/text-1.3:=[profile?] )
		( >=dev-haskell/text-2.0:=[profile?] <dev-haskell/text-2.2:=[profile?] ) )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? ( >=dev-haskell/quickcheck-2.9 <dev-haskell/quickcheck-3
		>=dev-haskell/quickcheck-instances-0.3.12 <dev-haskell/quickcheck-instances-0.4
		>=dev-haskell/tasty-0.7
		>=dev-haskell/tasty-quickcheck-0.7 <dev-haskell/tasty-quickcheck-1.0
		dev-haskell/text )
"
