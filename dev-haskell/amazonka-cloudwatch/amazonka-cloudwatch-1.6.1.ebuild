# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Amazon CloudWatch SDK"
HOMEPAGE="https://github.com/brendanhay/amazonka"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/amazonka-core-1.6.1:=[profile?] <dev-haskell/amazonka-core-1.6.2:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( >=dev-haskell/amazonka-test-1.6.1 <dev-haskell/amazonka-test-1.6.2
		dev-haskell/tasty
		dev-haskell/tasty-hunit
		dev-haskell/text
		dev-haskell/unordered-containers )
"
