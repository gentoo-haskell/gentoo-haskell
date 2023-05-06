# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.3.0

CABAL_HACKAGE_REVISION=2

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit ghc-package haskell-cabal

DESCRIPTION="Core effects for interacting with the Nix store"
HOMEPAGE="https://github.com/haskell-nix/hnix-store"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/${PN}-0.5.0.0-test-rtsopts.patch"
	"${FILESDIR}/${PN}-0.5.0.0-fix-tests.patch"
	"${FILESDIR}/${PN}-0.5.0.0-add-overloaded-strings.patch"
)

CABAL_CHDEPS=(
	'algebraic-graphs >= 0.5 && < 0.6' 'algebraic-graphs >= 0.5'
	'cryptonite < 0.30' 'cryptonite'
	'memory < 0.17' 'memory'
)

RDEPEND=">=dev-haskell/algebraic-graphs-0.5:=[profile?]
	<dev-haskell/attoparsec-0.15:=[profile?]
	<dev-haskell/base16-bytestring-1.1:=[profile?]
	<dev-haskell/base64-bytestring-1.3:=[profile?]
	<dev-haskell/cereal-0.6:=[profile?]
	dev-haskell/cryptonite:=[profile?]
	<dev-haskell/hashable-1.5:=[profile?]
	<dev-haskell/lifted-base-0.3:=[profile?]
	dev-haskell/memory:=[profile?]
	<dev-haskell/monad-control-1.1:=[profile?]
	>=dev-haskell/nix-derivation-1.1.1:=[profile?] <dev-haskell/nix-derivation-2:=[profile?]
	<dev-haskell/saltine-0.3:=[profile?]
	<dev-haskell/unordered-containers-0.3:=[profile?]
	<dev-haskell/vector-0.13:=[profile?]
	>=dev-lang/ghc-8.4.3:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? (
		dev-haskell/hspec
		dev-haskell/tasty
		dev-haskell/tasty-golden
		dev-haskell/tasty-hspec
		dev-haskell/tasty-hunit
		dev-haskell/tasty-quickcheck
		dev-haskell/temporary
	)
"
BDEPEND="
	test? (
		dev-haskell/tasty-discover[executable]
	)
"

src_configure() {
	if ghc-supports-smp; then
		local bounded_flag="bounded_memory"
	else
		local bounded_flag="-bounded_memory"
	fi

	haskell-cabal_src_configure \
		--flag="${bounded_flag}"
}
