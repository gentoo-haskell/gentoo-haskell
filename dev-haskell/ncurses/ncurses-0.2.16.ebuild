# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.5.9999
#hackport: flags: +use-pkgconfig,-force-narrow-library,-force-c2hs-newtype-pointer-hooks

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Modernised bindings to GNU ncurses"
HOMEPAGE="https://john-millikin.com/software/haskell-ncurses/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-haskell/text-0.7:=[profile?]
	>=dev-haskell/transformers-0.2:=[profile?]
	>=dev-lang/ghc-7.4.1:=[profile?]
	sys-libs/ncurses:0=
"
DEPEND="${RDEPEND}
	dev-haskell/c2hs
	>=dev-haskell/cabal-1.6
	virtual/pkgconfig
"

PATCHES=("${FILESDIR}"/${P}-ncurses-6.2_p2021.patch)

src_configure() {
	haskell-cabal_src_configure \
		--flag=-force-c2hs-newtype-pointer-hooks \
		--flag=-force-narrow-library \
		--flag=use-pkgconfig
}
