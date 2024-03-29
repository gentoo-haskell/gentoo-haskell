# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A high-performance time library"
HOMEPAGE="https://github.com/andrewthad/chronos"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/aeson-1.1:=[profile?] <dev-haskell/aeson-2.2:=[profile?]
	>=dev-haskell/attoparsec-0.13:=[profile?] <dev-haskell/attoparsec-0.15:=[profile?]
	>=dev-haskell/bytebuild-0.3.8:=[profile?] <dev-haskell/bytebuild-0.4:=[profile?]
	>=dev-haskell/byteslice-0.2.5.2:=[profile?] <dev-haskell/byteslice-0.3:=[profile?]
	>=dev-haskell/bytesmith-0.3.7:=[profile?] <dev-haskell/bytesmith-0.4:=[profile?]
	>=dev-haskell/hashable-1.2:=[profile?] <dev-haskell/hashable-1.5:=[profile?]
	>=dev-haskell/natural-arithmetic-0.1.2:=[profile?] <dev-haskell/natural-arithmetic-0.3:=[profile?]
	>=dev-haskell/primitive-0.6.4:=[profile?] <dev-haskell/primitive-0.10:=[profile?]
	>=dev-haskell/semigroups-0.16:=[profile?] <dev-haskell/semigroups-0.21:=[profile?]
	>=dev-haskell/text-short-0.1.3:=[profile?] <dev-haskell/text-short-0.2:=[profile?]
	>=dev-haskell/torsor-0.1:=[profile?] <dev-haskell/torsor-0.2:=[profile?]
	>=dev-haskell/vector-0.11:=[profile?] <dev-haskell/vector-0.14:=[profile?]
	>=dev-lang/ghc-8.10.6:=
	>=dev-haskell/text-1.2:=[profile?] <dev-haskell/text-2.1:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.2.1.0
	test? ( dev-haskell/hunit
		dev-haskell/quickcheck
		dev-haskell/test-framework
		dev-haskell/test-framework-hunit
		dev-haskell/test-framework-quickcheck2
		dev-haskell/text )
"
