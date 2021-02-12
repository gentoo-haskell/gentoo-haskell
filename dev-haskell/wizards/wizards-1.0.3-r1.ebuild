# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="High level, generic library for interrogative user interfaces"
HOMEPAGE="https://hackage.haskell.org/package/wizards"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/control-monad-free-0.5:=[profile?] <dev-haskell/control-monad-free-0.7:=[profile?]
	>=dev-haskell/haskeline-0.6:=[profile?] <dev-haskell/haskeline-0.9:=[profile?]
	>=dev-haskell/mtl-2.0:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
"

src_prepare() {
	default

	cabal_chdeps \
		'haskeline >= 0.6 && < 0.8' 'haskeline >= 0.6 && < 0.9'
}
