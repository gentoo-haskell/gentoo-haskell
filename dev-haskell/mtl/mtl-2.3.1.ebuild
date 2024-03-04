# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.0.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
# break circular dependencies:
# https://github.com/gentoo-haskell/gentoo-haskell/issues/810
CABAL_FEATURES+=" nocabaldep"
inherit haskell-cabal

DESCRIPTION="Monad classes, using functional dependencies"
HOMEPAGE="https://github.com/haskell/mtl"

LICENSE="BSD"
SLOT="0/${PV}"
# keep in sync with ghc-9.6?
#KEYWORDS="~amd64 ~amd64-linux ~ppc-macos"

RDEPEND="
	>=dev-lang/ghc-8.10.6:=
"
DEPEND="${RDEPEND}
"

CABAL_CORE_LIB_GHC_PV="9.6.2 9.6.3 9.6.4 9.8.2"
