# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.3.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Automatic recompilation and reloading of haskell modules"
HOMEPAGE="https://hackage.haskell.org/package/plugins-auto"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test" # missing files

RDEPEND=">=dev-haskell/hinotify-0.3.2:=[profile?]
		dev-haskell/mtl:=[profile?]
		>=dev-haskell/plugins-1.5.1.4:=[profile?]
		>=dev-lang/ghc-6.10.4:="
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ghc-7.6.patch
	epatch "${FILESDIR}"/${P}-ghc-7.10.patch
	epatch "${FILESDIR}"/${P}-hinotify-0.3.10.patch

	mkdir -p "${S}/Test" || die "Could not create Test directory"
	cp "${FILESDIR}/Test.hs" "${S}/Test/Test.hs" || die "Could not copy Test.hs"
}

src_configure() {
	cabal_src_configure $(use_enable test tests)
}
