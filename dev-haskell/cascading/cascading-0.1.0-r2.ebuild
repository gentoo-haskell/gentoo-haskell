# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.3.4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="DSL for HTML CSS (Cascading Style Sheets)"
HOMEPAGE="https://hackage.haskell.org/package/cascading"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/blaze-builder-0.3:=[profile?] <dev-haskell/blaze-builder-1:=[profile?]
	>=dev-haskell/colour-2.3:=[profile?] <dev-haskell/colour-3:=[profile?]
	>=dev-haskell/lens-3.9:=[profile?]
	>=dev-haskell/mtl-2.0:=[profile?] <dev-haskell/mtl-3:=[profile?]
	>=dev-haskell/text-0.11:=[profile?]
	>=dev-haskell/utf8-string-0.3:=[profile?]
	>=dev-haskell/web-routes-0.27:=[profile?] <dev-haskell/web-routes-1:=[profile?]
	>=dev-lang/ghc-7.6.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.16.0
"

PATCHES=(
	"${FILESDIR}"/${P}-lens-4.patch
	"${FILESDIR}"/${P}-ghc84.patch
)

src_prepare() {
	default

	cabal_chdeps \
		'text          >= 0.11 && < 1' 'text          >= 0.11' \
		'lens          >= 3.9  && < 4' 'lens          >= 3.9' \
		'utf8-string   >= 0.3  && < 1' 'utf8-string   >= 0.3'
}
