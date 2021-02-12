# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Core effects for interacting with the Nix store"
HOMEPAGE="https://github.com/haskell-nix/hnix-store"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="bounded-memory"

RDEPEND="dev-haskell/base16-bytestring:=[profile?]
	dev-haskell/cryptohash-md5:=[profile?]
	dev-haskell/cryptohash-sha1:=[profile?]
	dev-haskell/cryptohash-sha256:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/regex-base:=[profile?]
	>=dev-haskell/regex-tdfa-1.3.1.0:=[profile?]
	dev-haskell/saltine:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/vector:=[profile?]
	>=dev-lang/ghc-8.2.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.0.0.2
	test? ( dev-haskell/base64-bytestring
		dev-haskell/tasty
		dev-haskell/tasty-discover
		dev-haskell/tasty-hspec
		dev-haskell/tasty-hunit
		dev-haskell/tasty-quickcheck
		dev-haskell/temporary )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag bounded-memory bounded_memory)
}
