# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A pagination approach for yesod"
HOMEPAGE="https://github.com/pbrisbin/yesod-paginator"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="dev-haskell/blaze-markup:=[profile?]
	dev-haskell/path-pieces:=[profile?]
	>=dev-haskell/persistent-2.5:=[profile?]
	dev-haskell/safe:=[profile?]
	>=dev-haskell/text-0.11:=[profile?] <dev-haskell/text-2.0:=[profile?]
	dev-haskell/uri-encode:=[profile?]
	>=dev-haskell/yesod-core-1.4:=[profile?]
	>=dev-lang/ghc-7.10.1:=
	examples? ( dev-haskell/warp:=[profile?]
			dev-haskell/yesod:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.22.2.0
	test? ( dev-haskell/doctest
		dev-haskell/hspec
		dev-haskell/quickcheck
		dev-haskell/quickcheck-classes
		dev-haskell/yesod-test )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag examples examples)
}
