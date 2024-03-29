# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.5.1.9999
#hackport: flags: +template-haskell,-herbie

CABAL_HACKAGE_REVISION=3

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Linear Algebra"
HOMEPAGE="https://github.com/ekmett/linear/"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/adjunctions-4:=[profile?] <dev-haskell/adjunctions-5:=[profile?]
	>=dev-haskell/base-orphans-0.8.3:=[profile?] <dev-haskell/base-orphans-1:=[profile?]
	>=dev-haskell/bytes-0.15:=[profile?] <dev-haskell/bytes-1:=[profile?]
	>=dev-haskell/cereal-0.4.1.1:=[profile?] <dev-haskell/cereal-0.6:=[profile?]
	>=dev-haskell/distributive-0.5.1:=[profile?] <dev-haskell/distributive-1:=[profile?]
	>=dev-haskell/hashable-1.2.7.0:=[profile?] <dev-haskell/hashable-1.5:=[profile?]
	>=dev-haskell/indexed-traversable-0.1.1:=[profile?] <dev-haskell/indexed-traversable-0.2:=[profile?]
	>=dev-haskell/lens-4.15.2:=[profile?] <dev-haskell/lens-6:=[profile?]
	>=dev-haskell/random-1.0:=[profile?] <dev-haskell/random-1.3:=[profile?]
	>=dev-haskell/reflection-2:=[profile?] <dev-haskell/reflection-3:=[profile?]
	>=dev-haskell/semigroupoids-5.2.1:=[profile?] <dev-haskell/semigroupoids-7:=[profile?]
	>=dev-haskell/tagged-0.8.6:=[profile?] <dev-haskell/tagged-1:=[profile?]
	>=dev-haskell/transformers-compat-0.5.0.4:=[profile?] <dev-haskell/transformers-compat-1:=[profile?]
	>=dev-haskell/unordered-containers-0.2.3:=[profile?] <dev-haskell/unordered-containers-0.3:=[profile?]
	>=dev-haskell/vector-0.12.1.2:=[profile?] <dev-haskell/vector-0.14:=[profile?]
	>=dev-haskell/void-0.6:=[profile?] <dev-haskell/void-1:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? ( >=dev-haskell/hunit-1.2.5
		>=dev-haskell/simple-reflect-0.3.1
		>=dev-haskell/test-framework-0.8
		>=dev-haskell/test-framework-hunit-0.3 )
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=-herbie \
		--flag=template-haskell
}
