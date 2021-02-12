# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Reflex FRP host and widgets for vty applications"
HOMEPAGE="https://hackage.haskell.org/package/reflex-vty"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND=">=dev-haskell/bimap-0.3.3:=[profile?] <dev-haskell/bimap-0.5:=[profile?]
	>=dev-haskell/data-default-0.7.1:=[profile?] <dev-haskell/data-default-0.8:=[profile?]
	>=dev-haskell/dependent-map-0.2.4:=[profile?] <dev-haskell/dependent-map-0.4:=[profile?]
	>=dev-haskell/dependent-sum-0.3:=[profile?] <dev-haskell/dependent-sum-0.7:=[profile?]
	>=dev-haskell/exception-transformers-0.4.0:=[profile?] <dev-haskell/exception-transformers-0.5:=[profile?]
	>=dev-haskell/mtl-2.2.2:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/primitive-0.6.3:=[profile?] <dev-haskell/primitive-0.8:=[profile?]
	>=dev-haskell/ref-tf-0.4.0:=[profile?] <dev-haskell/ref-tf-0.5:=[profile?]
	>=dev-haskell/reflex-0.6.2:=[profile?] <dev-haskell/reflex-0.8:=[profile?]
	>=dev-haskell/stm-2.4:=[profile?] <dev-haskell/stm-2.6:=[profile?]
	>=dev-haskell/text-1.2.3:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-haskell/text-icu-0.7:=[profile?] <dev-haskell/text-icu-0.8:=[profile?]
	>=dev-haskell/vty-5.21:=[profile?] <dev-haskell/vty-5.29:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
"

PATCHES=(
		"${FILESDIR}/${PN}-0.1.3.0-add-examples-flag.patch"
#		"${FILESDIR}/${PN}-0.1.3.0-fix-host-hs.patch"
)

src_prepare() {
	default

	cabal_chdeps \
		"bimap                             >= 0.3.3 && < 0.4" "bimap >=0.3.3 && <0.5"
}

src_configure() {
	cabal_src_configure \
	$(cabal_flag examples)
}
