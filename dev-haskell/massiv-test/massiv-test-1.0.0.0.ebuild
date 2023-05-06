# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Library that contains generators, properties and tests for Massiv Array Library"
HOMEPAGE="https://github.com/lehins/massiv"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="dev-haskell/data-default-class:=[profile?]
	dev-haskell/exceptions:=[profile?]
	dev-haskell/hspec:=[profile?]
	>=dev-haskell/massiv-1.0:=[profile?] <dev-haskell/massiv-2:=[profile?]
	dev-haskell/primitive:=[profile?]
	dev-haskell/quickcheck:2=[profile?]
	dev-haskell/scheduler:=[profile?]
	dev-haskell/unliftio:=[profile?]
	dev-haskell/vector:=[profile?]
	>=dev-lang/ghc-8.4.3:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? ( dev-haskell/data-default
		dev-haskell/genvalidity-hspec
		dev-haskell/mwc-random )
"
