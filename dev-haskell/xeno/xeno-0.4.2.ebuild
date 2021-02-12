# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A fast event-based XML parser in pure Haskell"
HOMEPAGE="https://github.com/ocramz/xeno"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="libxml2"

RDEPEND=">=dev-haskell/mtl-2.2.1:=[profile?]
	>=dev-haskell/mutable-containers-0.3.3:=[profile?]
	>=dev-haskell/vector-0.11:=[profile?]
	>=dev-lang/ghc-8.0.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.24.0.0
	test? ( dev-haskell/hexml
		dev-haskell/hspec )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag libxml2 libxml2)
}
