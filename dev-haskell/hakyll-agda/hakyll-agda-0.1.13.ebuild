# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Wrapper to integrate literate Agda files with Hakyll"
HOMEPAGE="https://github.com/bitonic/hakyll-agda"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-text/pandoc:=[profile?]
	>=dev-haskell/hakyll-4.7.2.0:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/xhtml:=[profile?]
	>=dev-lang/ghc-8.4.3:=
	>=sci-mathematics/agda-2.6.1:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
"
