# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="\"base\" package sans \"Prelude\" module"
HOMEPAGE="https://github.com/hvr/base-noprelude"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-8.8.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.0
"

src_prepare() {
	default

	cabal_chdeps \
		'build-depends:       base ==4.13.0.0' 'build-depends:       base >=4.13.0.0'
}
