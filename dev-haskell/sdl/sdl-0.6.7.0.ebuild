# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.2

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

MY_PN="SDL"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Binding to libSDL"
HOMEPAGE="https://hackage.haskell.org/package/SDL"
SRC_URI="https://hackage.haskell.org/package/${MY_P}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-7.4.1:=
	media-libs/libsdl
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.24
"

S="${WORKDIR}/${MY_P}"
