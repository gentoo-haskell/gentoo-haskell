# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="GI friendly Binding to the Cairo library"
HOMEPAGE="https://github.com/cohomology/gi-cairo-render"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+cairo-pdf +cairo-ps +cairo-svg"

RDEPEND=">=dev-haskell/haskell-gi-base-0.24:=[profile?] <dev-haskell/haskell-gi-base-0.25:=[profile?]
	>=dev-haskell/mtl-2.2:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/text-1.0.0.0:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-haskell/utf8-string-0.2:=[profile?] <dev-haskell/utf8-string-1.1:=[profile?]
	>=dev-lang/ghc-7.8.2:=
	x11-libs/cairo
"
DEPEND="${RDEPEND}
	>=dev-haskell/c2hs-0.28 <dev-haskell/c2hs-0.30
	>=dev-haskell/cabal-2.0
	virtual/pkgconfig
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag cairo-pdf cairo_pdf) \
		$(cabal_flag cairo-ps cairo_ps) \
		$(cabal_flag cairo-svg cairo_svg)
}
