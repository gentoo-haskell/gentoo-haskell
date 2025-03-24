# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.5.1.9999
#hackport: flags: -bytestring-builder,-developer,-integer-simple

CABAL_HACKAGE_REVISION=1

CABAL_FEATURES="lib profile haddock hoogle hscolour" # circular deps in test-suite
# break circular dependencies:
# https://github.com/gentoo-haskell/gentoo-haskell/issues/810
CABAL_FEATURES+=" nocabaldep"
inherit haskell-cabal

DESCRIPTION="An efficient packed Unicode text type"
HOMEPAGE="https://github.com/haskell/text"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~amd64-linux"
IUSE="+simdutf"

# break cyclic dependencies:
RESTRICT=test

RDEPEND="
	|| (
		>=dev-lang/ghc-9.4
		(
			>=dev-lang/ghc-9.0.2 <dev-lang/ghc-9.4
			>=dev-haskell/data-array-byte-0.1[profile?] <dev-haskell/data-array-byte-0.2[profile?]
		)
	)
	dev-lang/ghc:=
	simdutf? (
		|| (
			llvm-core/clang
			sys-devel/gcc[cxx]
		)
	)
"
DEPEND="${RDEPEND}
"

#	test? ( >=dev-haskell/quickcheck-2.12.6 <dev-haskell/quickcheck-2.16
#		dev-haskell/tasty
#		dev-haskell/tasty-hunit
#		dev-haskell/tasty-inspection-testing
#		dev-haskell/tasty-quickcheck )

src_configure() {
	haskell-cabal_src_configure \
		--flag=-bytestring-builder \
		--flag=-developer \
		--flag=-integer-simple \
		$(cabal_flag simdutf simdutf)
}

CABAL_CORE_LIB_GHC_PV="9.12.1 9.12.2"
