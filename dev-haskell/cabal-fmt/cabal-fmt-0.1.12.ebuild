# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999

CABAL_FEATURES="test-suite"
inherit haskell-cabal

DESCRIPTION="Format .cabal files"
HOMEPAGE="https://hackage.haskell.org/package/cabal-fmt"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/cabal-syntax-3.12.0.0:= <dev-haskell/cabal-syntax-3.13:=
	>=dev-haskell/optparse-applicative-0.14.3.0:= <dev-haskell/optparse-applicative-0.19:=
	>=dev-haskell/parsec-3.1.13.0:= <dev-haskell/parsec-3.2:=
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? ( >=dev-haskell/integer-logarithms-1.0.3.1 <dev-haskell/integer-logarithms-1.1
		dev-haskell/quickcheck
		dev-haskell/tasty
		dev-haskell/tasty-golden
		dev-haskell/tasty-hunit
		dev-haskell/tasty-quickcheck
		dev-haskell/temporary )
"

CABAL_CORE_LIB_GHC_PV="9.10.1"
