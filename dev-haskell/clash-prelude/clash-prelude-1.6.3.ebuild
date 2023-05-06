# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.2.2.9999

# doctest-parallel doesn't work, hence -doctests
# See: <https://github.com/martijnbastiaan/doctest-parallel/issues/45>
#hackport: flags: -doctests,unittests:test,-large-tuples,-multiple-hidden,-strict-mapsignal,-super-strict,-benchmarks

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Clash: a functional hardware description language - Prelude library"
HOMEPAGE="https://clash-lang.org/"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CABAL_CHDEPS=(
	"lens                      >= 4.10    && < 5.1.0" "lens >=4.10"
)

RDEPEND="
	>=dev-haskell/arrows-0.4:=[profile?] <dev-haskell/arrows-0.5:=[profile?]
	>=dev-haskell/constraints-0.9:=[profile?] <dev-haskell/constraints-1.0:=[profile?]
	>=dev-haskell/data-binary-ieee754-0.4.4:=[profile?] <dev-haskell/data-binary-ieee754-0.6:=[profile?]
	>=dev-haskell/data-default-class-0.1.2:=[profile?] <dev-haskell/data-default-class-0.2:=[profile?]
	>=dev-haskell/extra-1.6.17:=[profile?] <dev-haskell/extra-1.8:=[profile?]
	>=dev-haskell/ghc-typelits-extra-0.4:=[profile?] <dev-haskell/ghc-typelits-extra-0.5:=[profile?]
	>=dev-haskell/ghc-typelits-knownnat-0.7.2:=[profile?] <dev-haskell/ghc-typelits-knownnat-0.8:=[profile?]
	>=dev-haskell/ghc-typelits-natnormalise-0.7.2:=[profile?] <dev-haskell/ghc-typelits-natnormalise-0.8:=[profile?]
	>=dev-haskell/half-0.2.2.3:=[profile?] <dev-haskell/half-1.0:=[profile?]
	>=dev-haskell/hashable-1.2.1.0:=[profile?] <dev-haskell/hashable-1.5:=[profile?]
	>=dev-haskell/interpolate-0.2:=[profile?] <dev-haskell/interpolate-0.3:=[profile?]
	>=dev-haskell/lens-4.10:=[profile?]
	>=dev-haskell/quickcheck-2.7:2=[profile?] <dev-haskell/quickcheck-2.15:2=[profile?]
	>=dev-haskell/recursion-schemes-5.1:=[profile?] <dev-haskell/recursion-schemes-5.3:=[profile?]
	>=dev-haskell/reflection-2:=[profile?] <dev-haskell/reflection-2.2:=[profile?]
	>=dev-haskell/singletons-2.0:=[profile?] <dev-haskell/singletons-3.1:=[profile?]
	>=dev-haskell/th-abstraction-0.2.10:=[profile?] <dev-haskell/th-abstraction-0.5.0:=[profile?]
	>=dev-haskell/th-lift-0.7.0:=[profile?] <dev-haskell/th-lift-0.9:=[profile?]
	>=dev-haskell/th-orphans-0.13.1:=[profile?] <dev-haskell/th-orphans-1.0:=[profile?]
	>=dev-haskell/type-errors-0.2.0.0:=[profile?] <dev-haskell/type-errors-0.3:=[profile?]
	>=dev-haskell/uniplate-1.6.12:=[profile?] <dev-haskell/uniplate-1.7:=[profile?]
	>=dev-haskell/vector-0.11:=[profile?] <dev-haskell/vector-1.0:=[profile?]
	>=dev-lang/ghc-8.4.3:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? (
		>=dev-haskell/hedgehog-1.0.3 <dev-haskell/hedgehog-1.2
		>=dev-haskell/hint-0.7 <dev-haskell/hint-0.10
		>=dev-haskell/quickcheck-classes-base-0.6 <dev-haskell/quickcheck-classes-base-1.0
		>=dev-haskell/tasty-1.2 <dev-haskell/tasty-1.5
		>=dev-haskell/tasty-hedgehog-1.2.0
		dev-haskell/tasty-hunit
		dev-haskell/tasty-quickcheck
		dev-haskell/tasty-th
	)
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=-benchmarks \
		--flag=-doctests \
		--flag=-large-tuples \
		--flag=-multiple-hidden \
		--flag=-strict-mapsignal \
		--flag=-super-strict \
		$(cabal_flag test unittests)
}
