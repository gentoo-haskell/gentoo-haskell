# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.5.1.9999

CABAL_HACKAGE_REVISION=2

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Type definitions for Universally Unique Identifiers"
HOMEPAGE="https://github.com/haskell-hvr/uuid"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

RDEPEND=">=dev-haskell/hashable-1.4.4.0:=[profile?] <dev-haskell/hashable-1.6:=[profile?]
	>=dev-haskell/random-1.2.1.2:=[profile?] <dev-haskell/random-1.3:=[profile?]
	>=dev-lang/ghc-9.0.2:=
	>=dev-haskell/text-1.2.3.0:=[profile?] <dev-haskell/text-2.2:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? ( >=dev-haskell/quickcheck-2.14.2 <dev-haskell/quickcheck-2.16
		>=dev-haskell/tasty-1.4.0.1 <dev-haskell/tasty-1.6
		>=dev-haskell/tasty-hunit-0.10 <dev-haskell/tasty-hunit-0.11
		>=dev-haskell/tasty-quickcheck-0.10 <dev-haskell/tasty-quickcheck-0.12 )
"
