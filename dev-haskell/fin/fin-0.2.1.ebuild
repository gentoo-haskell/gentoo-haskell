# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.3.0

CABAL_HACKAGE_REVISION=1

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Nat and Fin: peano naturals and finite numbers"
HOMEPAGE="https://github.com/phadej/vec"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/boring-0.2:=[profile?] <dev-haskell/boring-0.3:=[profile?]
	>=dev-haskell/dec-0.0.4:=[profile?] <dev-haskell/dec-0.1:=[profile?]
	>=dev-haskell/hashable-1.2.7.0:=[profile?] <dev-haskell/hashable-1.5:=[profile?]
	>=dev-haskell/quickcheck-2.13.2:2=[profile?] <dev-haskell/quickcheck-2.15:2=[profile?]
	>=dev-haskell/some-1.0.3:=[profile?] <dev-haskell/some-1.1:=[profile?]
	>=dev-haskell/universe-base-1.1.2:=[profile?] <dev-haskell/universe-base-1.2:=[profile?]
	>=dev-lang/ghc-8.4.3:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? ( >=dev-haskell/inspection-testing-0.2.0.1 <dev-haskell/inspection-testing-0.6
		dev-haskell/tagged )
"
