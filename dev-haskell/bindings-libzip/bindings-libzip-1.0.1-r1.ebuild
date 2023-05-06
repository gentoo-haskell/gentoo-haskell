# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.5.9999
#hackport: flags: -nopkgconfig

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Low level bindings to libzip"
HOMEPAGE="http://bitbucket.org/astanin/hs-libzip/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-haskell/bindings-dsl-1.0:=[profile?] <dev-haskell/bindings-dsl-1.1:=[profile?]
	>=dev-lang/ghc-7.4.1:=[profile?]
	dev-libs/libzip
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.2.3
	virtual/pkgconfig
"

PATCHES=("${FILESDIR}"/${P}-libzip-1.2.0.patch)

src_configure() {
	haskell-cabal_src_configure \
		--flag=-nopkgconfig
}
