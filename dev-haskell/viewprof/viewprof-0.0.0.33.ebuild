# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.5.9999

CABAL_FEATURES=""
inherit haskell-cabal

DESCRIPTION="Text-based interactive GHC .prof viewer"
HOMEPAGE="https://github.com/maoe/viewprof"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">dev-haskell/brick-0.26.1:= <dev-haskell/brick-0.54:=
	>=dev-haskell/ghc-prof-1.4:= <dev-haskell/ghc-prof-1.5:=
	>=dev-haskell/lens-4.14:= <dev-haskell/lens-4.20:=
	>=dev-haskell/scientific-0.3.4.4:= <dev-haskell/scientific-0.4:=
	>=dev-haskell/text-1.2.2.0:= <dev-haskell/text-1.3:=
	>=dev-haskell/vector-0.10.12.3:= <dev-haskell/vector-0.13:=
	>=dev-haskell/vector-algorithms-0.6.0.4:= <dev-haskell/vector-algorithms-0.9:=
	>=dev-haskell/vty-5.13:= <dev-haskell/vty-5.29:=
	>=dev-lang/ghc-8.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.24.2.0
"
