# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.4

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Pattern language for improvised music"
HOMEPAGE="http://tidalcycles.org/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="<dev-haskell/bifunctors-5.6:=[profile?]
	<dev-haskell/clock-0.9:=[profile?]
	<dev-haskell/colour-2.4:=[profile?]
	>=dev-haskell/hosc-0.17:=[profile?] <dev-haskell/hosc-0.18:=[profile?]
	<dev-haskell/mwc-random-0.15:=[profile?]
	<dev-haskell/network-3.2:=[profile?]
	>=dev-haskell/parsec-3.1.12:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	<dev-haskell/primitive-0.8:=[profile?]
	<dev-haskell/random-1.2:=[profile?]
	>=dev-haskell/semigroups-0.18:=[profile?] <dev-haskell/semigroups-0.20:=[profile?]
	<dev-haskell/text-1.3:=[profile?]
	<dev-haskell/vector-0.13:=[profile?]
	>=dev-lang/ghc-8.0.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.24.0.0
	test? ( >=dev-haskell/microspec-0.2.0.1 )
"
