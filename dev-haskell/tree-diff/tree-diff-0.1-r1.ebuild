# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Diffing of (expression) trees"
HOMEPAGE="https://github.com/phadej/tree-diff"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/aeson-1.4.0.0:=[profile?]
	>=dev-haskell/ansi-terminal-0.8.1:=[profile?]
	>=dev-haskell/ansi-wl-pprint-0.6.8.2:=[profile?] <dev-haskell/ansi-wl-pprint-0.7:=[profile?]
	>=dev-haskell/base-compat-0.9.3:=[profile?]
	>=dev-haskell/bytestring-builder-0.10.8.2.0:=[profile?] <dev-haskell/bytestring-builder-0.11:=[profile?]
	>=dev-haskell/generics-sop-0.3.1.0:=[profile?] <dev-haskell/generics-sop-0.6:=[profile?]
	>=dev-haskell/hashable-1.2.7.0:=[profile?] <dev-haskell/hashable-1.4:=[profile?]
	>=dev-haskell/memotrie-0.6.8:=[profile?] <dev-haskell/memotrie-0.7:=[profile?]
	>=dev-haskell/nats-1.1.2:=[profile?] <dev-haskell/nats-1.2:=[profile?]
	>=dev-haskell/parsec-3.1.13.0:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-haskell/parsers-0.12.10:=[profile?] <dev-haskell/parsers-0.13:=[profile?]
	>=dev-haskell/quickcheck-2.10.0.1:2=[profile?] <dev-haskell/quickcheck-2.15:=[profile?]
	>=dev-haskell/scientific-0.3.6.2:=[profile?] <dev-haskell/scientific-0.4:=[profile?]
	>=dev-haskell/semigroups-0.18.5:=[profile?] <dev-haskell/semigroups-0.20:=[profile?]
	>=dev-haskell/tagged-0.8.6:=[profile?] <dev-haskell/tagged-0.9:=[profile?]
	>=dev-haskell/text-1.2.3.0:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-haskell/unordered-containers-0.2.8.0:=[profile?] <dev-haskell/unordered-containers-0.3:=[profile?]
	>=dev-haskell/uuid-types-1.0.3:=[profile?] <dev-haskell/uuid-types-1.1:=[profile?]
	>=dev-haskell/vector-0.12:=[profile?] <dev-haskell/vector-0.13:=[profile?]
	>=dev-haskell/void-0.7.3:=[profile?] <dev-haskell/void-0.8:=[profile?]
	>=dev-lang/ghc-7.10:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( >=dev-haskell/tasty-1.2 <dev-haskell/tasty-1.3
		>=dev-haskell/tasty-golden-2.3.1.1 <dev-haskell/tasty-golden-2.4
		>=dev-haskell/tasty-quickcheck-0.10.1 <dev-haskell/tasty-quickcheck-0.11
		>=dev-haskell/trifecta-2.0 )
"

src_prepare() {
	default

	cabal_chdeps \
		'ansi-terminal         ^>=0.8.2 || ^>=0.9.1' 'ansi-terminal         >=0.8.2' \
		'base        >=4.5      && <4.13' 'base        >=4.5' \
		'time        ^>=1.4 || ^>=1.5.0.1 || ^>=1.6.0.1 || ^>=1.8.0.2' 'time        >=1.4' \
		'base-compat           ^>=0.10.5' 'base-compat           >=0.10.5' \
		'trifecta          ^>=2' 'trifecta          >=2' \
		'QuickCheck            ^>=2.12.6.1 || ^>=2.13.1' 'QuickCheck >= 2.12.6.1' \
		'aeson                 ^>=1.4.0.0' 'aeson >= 1.4.0.0'
}
