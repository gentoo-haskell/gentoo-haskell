# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.6

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Audio signal processing with static physical dimensions"
HOMEPAGE="https://www.haskell.org/haskellwiki/Synthesizer"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/event-list-0.1:=[profile?] <dev-haskell/event-list-0.2:=[profile?]
	>=dev-haskell/non-negative-0.1:=[profile?] <dev-haskell/non-negative-0.2:=[profile?]
	>=dev-haskell/numeric-prelude-0.3:=[profile?] <dev-haskell/numeric-prelude-0.5:=[profile?]
	>=dev-haskell/random-1.0:=[profile?] <dev-haskell/random-2.0:=[profile?]
	>=dev-haskell/semigroups-0.1:=[profile?] <dev-haskell/semigroups-1.0:=[profile?]
	>=dev-haskell/sox-0.2:=[profile?] <dev-haskell/sox-0.3:=[profile?]
	>=dev-haskell/storable-record-0.0.1:=[profile?] <dev-haskell/storable-record-0.1:=[profile?]
	>=dev-haskell/storablevector-0.2.3:=[profile?] <dev-haskell/storablevector-0.3:=[profile?]
	>=dev-haskell/synthesizer-core-0.8.1:=[profile?] <dev-haskell/synthesizer-core-0.9:=[profile?]
	>=dev-haskell/utility-ht-0.0.5:=[profile?] <dev-haskell/utility-ht-0.1:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
"
