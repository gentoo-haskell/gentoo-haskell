# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.3.0

CABAL_HACKAGE_REVISION=6

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Collection of user contributions to diagrams EDSL"
HOMEPAGE="https://diagrams.github.io/"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-haskell/circle-packing-0.1:=[profile?] <dev-haskell/circle-packing-0.2:=[profile?]
	>=dev-haskell/colour-2.3.1:=[profile?] <dev-haskell/colour-2.4:=[profile?]
	>=dev-haskell/cubicbezier-0.6:=[profile?] <dev-haskell/cubicbezier-0.7:=[profile?]
	>=dev-haskell/data-default-0.5.2:=[profile?] <dev-haskell/data-default-0.8:=[profile?]
	<dev-haskell/data-default-class-0.2:=[profile?]
	>=dev-haskell/diagrams-core-1.4:=[profile?] <dev-haskell/diagrams-core-1.6:=[profile?]
	>=dev-haskell/diagrams-lib-1.4:=[profile?] <dev-haskell/diagrams-lib-1.5:=[profile?]
	>=dev-haskell/diagrams-solve-0.1:=[profile?] <dev-haskell/diagrams-solve-0.2:=[profile?]
	>=dev-haskell/force-layout-0.4:=[profile?] <dev-haskell/force-layout-0.5:=[profile?]
	>=dev-haskell/hashable-0.1.2:=[profile?] <dev-haskell/hashable-1.5:=[profile?]
	>=dev-haskell/lens-4.0:=[profile?] <dev-haskell/lens-5.3:=[profile?]
	>=dev-haskell/linear-1.11.3:=[profile?] <dev-haskell/linear-1.22:=[profile?]
	>=dev-haskell/mfsolve-0.3:=[profile?] <dev-haskell/mfsolve-0.4:=[profile?]
	>=dev-haskell/monadrandom-0.1.8:=[profile?] <dev-haskell/monadrandom-0.6:=[profile?]
	>=dev-haskell/monoid-extras-0.4.2:=[profile?] <dev-haskell/monoid-extras-0.7:=[profile?]
	>=dev-haskell/mtl-compat-0.2.1:=[profile?] <dev-haskell/mtl-compat-0.3:=[profile?]
	>=dev-haskell/random-1.0:=[profile?] <dev-haskell/random-1.3:=[profile?]
	>=dev-haskell/semigroups-0.3.4:=[profile?] <dev-haskell/semigroups-0.21:=[profile?]
	>=dev-haskell/split-0.2.1:=[profile?] <dev-haskell/split-0.3:=[profile?]
	>=dev-lang/ghc-8.4.3:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? (
		>=dev-haskell/hunit-1.2 <dev-haskell/hunit-1.7
		>=dev-haskell/quickcheck-2.4 <dev-haskell/quickcheck-2.15
		>=dev-haskell/test-framework-0.4 <dev-haskell/test-framework-0.9
		>=dev-haskell/test-framework-hunit-0.2 <dev-haskell/test-framework-hunit-0.4
		>=dev-haskell/test-framework-quickcheck2-0.2 <dev-haskell/test-framework-quickcheck2-0.4
	)
"
