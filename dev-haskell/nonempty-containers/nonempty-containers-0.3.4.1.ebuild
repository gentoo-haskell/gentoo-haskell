# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Non-empty variants of containers data types, with full API"
HOMEPAGE="https://github.com/mstksg/nonempty-containers#readme"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/comonad:=[profile?]
	dev-haskell/nonempty-vector:=[profile?]
	dev-haskell/semigroupoids:=[profile?]
	dev-haskell/these:=[profile?]
	dev-haskell/vector:=[profile?]
	>=dev-lang/ghc-8.2.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.0.0.2
	test? ( >=dev-haskell/hedgehog-1.0
		>=dev-haskell/hedgehog-fn-1.0
		dev-haskell/tasty
		>=dev-haskell/tasty-hedgehog-1.0
		dev-haskell/text )
"
