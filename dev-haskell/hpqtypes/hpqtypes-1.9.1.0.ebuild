# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Haskell bindings to libpqtypes"
HOMEPAGE="https://github.com/scrive/hpqtypes"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT=test # connection problems, seems to require postgres instance

RDEPEND=">=dev-db/postgresql-7
	>=dev-haskell/aeson-1.0:=[profile?]
	>=dev-haskell/async-2.1.1.1:=[profile?]
	>=dev-haskell/exceptions-0.6:=[profile?]
	>=dev-haskell/lifted-base-0.2:=[profile?]
	>=dev-haskell/monad-control-0.3:=[profile?]
	>=dev-haskell/mtl-2.1:=[profile?]
	>=dev-haskell/resource-pool-0.2:=[profile?]
	>=dev-haskell/semigroups-0.16:=[profile?]
	>=dev-haskell/text-0.11:=[profile?]
	>=dev-haskell/text-show-2:=[profile?]
	>=dev-haskell/transformers-base-0.4:=[profile?]
	>=dev-haskell/uuid-types-1.0.3:=[profile?]
	>=dev-haskell/vector-0.10:=[profile?]
	>=dev-lang/ghc-8.0.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.24.0.0 <dev-haskell/cabal-3.3
	test? ( >=dev-haskell/hunit-1.2
		>=dev-haskell/quickcheck-2.5
		>=dev-haskell/random-1.0
		dev-haskell/scientific
		>=dev-haskell/test-framework-0.8
		>=dev-haskell/test-framework-hunit-0.3
		dev-haskell/unordered-containers )
"
