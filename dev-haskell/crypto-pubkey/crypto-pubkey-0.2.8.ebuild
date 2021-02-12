# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Public Key cryptography"
HOMEPAGE="https://github.com/vincenthz/hs-crypto-pubkey"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT=test # missing files

RDEPEND="dev-haskell/byteable:=[profile?]
	>=dev-haskell/crypto-numbers-0.2.2:=[profile?]
	>=dev-haskell/crypto-pubkey-types-0.4.1:=[profile?] <dev-haskell/crypto-pubkey-types-0.5:=[profile?]
	>=dev-haskell/crypto-random-0.0:=[profile?] <dev-haskell/crypto-random-0.1:=[profile?]
	>=dev-haskell/cryptohash-0.9.1:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( dev-haskell/tasty
		dev-haskell/tasty-hunit
		dev-haskell/tasty-kat
		dev-haskell/tasty-quickcheck )
"
