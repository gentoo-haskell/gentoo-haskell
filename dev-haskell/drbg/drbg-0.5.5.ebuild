# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

MY_PN="DRBG"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Deterministic random bit generator (aka PRNG) based HMACs, Hashes, and Ciphers"
HOMEPAGE="https://hackage.haskell.org/package/DRBG"
SRC_URI="https://hackage.haskell.org/package/${MY_P}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RESTRICT=test # fails own tests

RDEPEND=">=dev-haskell/cereal-0.5:=[profile?] <dev-haskell/cereal-0.6:=[profile?]
	>=dev-haskell/cipher-aes128-0.6:=[profile?]
	>=dev-haskell/crypto-api-0.13:=[profile?]
	>=dev-haskell/cryptohash-cryptoapi-0.1:=[profile?]
	dev-haskell/entropy:=[profile?]
	>=dev-haskell/mtl-2.0:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	dev-haskell/parallel:=[profile?]
	dev-haskell/prettyclass:=[profile?]
	>=dev-haskell/tagged-0.7:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( dev-haskell/crypto-api-tests
		dev-haskell/hunit
		dev-haskell/quickcheck
		dev-haskell/test-framework
		dev-haskell/test-framework-hunit )
"

S="${WORKDIR}/${MY_P}"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag test test)
}
