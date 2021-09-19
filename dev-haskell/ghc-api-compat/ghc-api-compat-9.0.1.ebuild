# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="GHC-API compatibility helpers"
HOMEPAGE="https://hackage.haskell.org/package/ghc-api-compat"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS=""

RDEPEND=">=dev-lang/ghc-9.0:=[profile?] <dev-lang/ghc-9.1:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.4.0.1
"
