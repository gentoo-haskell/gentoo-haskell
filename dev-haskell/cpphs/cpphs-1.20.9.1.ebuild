# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999

CABAL_HACKAGE_REVISION=1

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

CABAL_CHDEPS=('time >=1.5 && <1.13' 'time >=1.5 && <1.15')

DESCRIPTION="A liberalised re-implementation of cpp, the C pre-processor"
HOMEPAGE="https://projects.haskell.org/cpphs/"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/polyparse-1.13:=[profile?] <dev-haskell/polyparse-1.14:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
"
