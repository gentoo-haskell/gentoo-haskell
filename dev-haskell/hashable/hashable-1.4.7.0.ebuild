# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.5.1.9999
#hackport: flags: sse41:cpu_flags_x86_sse4_1,sse2:cpu_flags_x86_sse2,+integer-gmp,-arch-native

CABAL_FEATURES="lib profile haddock hoogle hscolour" # test-suite
inherit haskell-cabal

DESCRIPTION="A class for types that can be converted to a hash value"
HOMEPAGE="https://github.com/haskell-unordered-containers/hashable"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE="ghc-9-0 random-initial-seed"

# The random inital seed causes the "64 bit Text" test to fail
RESTRICT_USE="random-initial-seed? ( !test )"

RESTRICT="test" # The tests pull in new versions of tasty which aren't ready

RDEPEND=">=dev-haskell/base-orphans-0.8.6:=[profile?] <dev-haskell/base-orphans-0.10:=[profile?]
	>=dev-haskell/data-array-byte-0.1.0.1:=[profile?] <dev-haskell/data-array-byte-0.2:=[profile?]
	>=dev-lang/ghc-9.0.2:=
	|| (
		( >=dev-haskell/text-1.2.3.0 <dev-haskell/text-1.3 )
		( >=dev-haskell/text-2.0 <dev-haskell/text-2.2 )
	)
	dev-haskell/text:=[profile?]
	ghc-9-0? (
		>=dev-lang/ghc-9.0.2:= <dev-lang/ghc-9.1
	)
	!ghc-9-0? (
		>=dev-lang/ghc-9.2:=
		dev-haskell/os-string:=[profile?]
	)
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
"
#	test? ( dev-haskell/hunit
#		>=dev-haskell/primitive-0.9.0.0 <dev-haskell/primitive-0.10
#		>=dev-haskell/quickcheck-2.4.0.1
#		>=dev-haskell/random-1.0 <dev-haskell/random-1.3
#		>=dev-haskell/tasty-1.5 <dev-haskell/tasty-1.6
#		>=dev-haskell/tasty-hunit-0.10.1 <dev-haskell/tasty-hunit-0.11
#		>=dev-haskell/tasty-quickcheck-0.10.3 <dev-haskell/tasty-quickcheck-0.11
#		>=dev-haskell/text-0.11.0.5 )

src_configure() {
	haskell-cabal_src_configure \
		--flag=-arch-native \
		--flag=integer-gmp \
		$(cabal_flag random-initial-seed random-initial-seed)
}
