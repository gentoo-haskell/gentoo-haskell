# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.3

CABAL_FEATURES="lib haddock hoogle hscolour" # drop USE=profile as __attribute__ mangling is not compatible with glibc
inherit haskell-cabal

DESCRIPTION="Binding to the libsvg-cairo library"
HOMEPAGE="http://projects.haskell.org/gtk2hs/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/cairo-0.13.0.0:= <dev-haskell/cairo-0.14:=
	>=dev-haskell/glib-0.13.0.0:= <dev-haskell/glib-0.14:=
	dev-haskell/mtl:=
	dev-haskell/text:=
	>=dev-lang/ghc-7.4.1:=
	gnome-base/librsvg
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.24 <dev-haskell/cabal-3.1
	>=dev-haskell/gtk2hs-buildtools-0.13.2.0 <dev-haskell/gtk2hs-buildtools-0.14
	virtual/pkgconfig
"
