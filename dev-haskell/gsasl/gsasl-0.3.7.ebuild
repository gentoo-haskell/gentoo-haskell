# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Bindings for GNU libgsasl"
HOMEPAGE="https://git.sr.ht/~singpolyma/gsasl-haskell"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-haskell/monad-loops-0.3:=[profile?]
	>=dev-lang/ghc-7.8.2:=
	virtual/gsasl
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	virtual/pkgconfig
"
