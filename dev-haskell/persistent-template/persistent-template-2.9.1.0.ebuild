# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Type-safe, non-relational, multi-backend persistence"
HOMEPAGE="https://www.yesodweb.com/book/persistent"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/aeson-1.0:=[profile?] <dev-haskell/aeson-1.6:=[profile?]
	>=dev-haskell/http-api-data-0.3.7:=[profile?]
	>=dev-haskell/monad-control-1.0:=[profile?] <dev-haskell/monad-control-1.1:=[profile?]
	dev-haskell/monad-logger:=[profile?]
	dev-haskell/path-pieces:=[profile?]
	>=dev-haskell/persistent-2.11:=[profile?] <dev-haskell/persistent-3:=[profile?]
	>=dev-haskell/text-1.2:=[profile?]
	>=dev-haskell/th-lift-instances-0.1.14:=[profile?] <dev-haskell/th-lift-instances-0.2:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	>=dev-lang/ghc-8.2.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.0.0.2
	test? ( >=dev-haskell/hspec-2.4
		dev-haskell/quickcheck )
"
