# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.3.0

CABAL_HACKAGE_REVISION=5

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A variety of alternative parser combinator libraries"
HOMEPAGE="https://code.haskell.org/~malcolm/polyparse/"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-lang/ghc-8.4.3:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
"
