# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.9999
#hackport: flags: -build-readme

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Utility package for constraints"
HOMEPAGE="https://github.com/obsidiansystems/constraints-extras"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/constraints-0.9:=[profile?] <dev-haskell/constraints-0.12:=[profile?]
	>=dev-lang/ghc-8.0.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.0
"

src_prepare() {
	default

	cabal_chdeps \
		'base >=4.9 && <4.14' 'base >=4.9' \
		'template-haskell >=2.11 && <2.16' 'template-haskell >=2.11'
}

src_configure() {
	haskell-cabal_src_configure \
		--flag=-build-readme
}
