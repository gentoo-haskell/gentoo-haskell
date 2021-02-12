# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.1

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="portable, type-safe URL routing"
HOMEPAGE="http://www.happstack.com/docs/crashcourse/index.html#web-routes"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/blaze-builder-0.2:=[profile?] <dev-haskell/blaze-builder-0.5:=[profile?]
	>=dev-haskell/exceptions-0.6.1:=[profile?] <dev-haskell/exceptions-0.11:=[profile?]
	>=dev-haskell/http-types-0.6:=[profile?] <dev-haskell/http-types-0.13:=[profile?]
	>=dev-haskell/mtl-2.0:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/parsec-2:=[profile?] <dev-haskell/parsec-4:=[profile?]
	dev-haskell/split:=[profile?]
	>=dev-haskell/text-0.11:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-haskell/utf8-string-0.3:=[profile?] <dev-haskell/utf8-string-1.1:=[profile?]
	>=dev-lang/ghc-8.0.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.24.0.0
	test? ( dev-haskell/hspec
		dev-haskell/hunit
		dev-haskell/quickcheck )
"
