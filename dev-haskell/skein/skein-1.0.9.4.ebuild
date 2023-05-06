# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Skein, a family of cryptographic hash functions.  Includes Skein-MAC as well"
HOMEPAGE="https://github.com/meteficha/skein"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="big-endian force-endianness reference"

RDEPEND=">=dev-haskell/cereal-0.3:=[profile?] <dev-haskell/cereal-0.6:=[profile?]
	>=dev-haskell/crypto-api-0.6:=[profile?] <dev-haskell/crypto-api-0.14:=[profile?]
	>=dev-haskell/tagged-0.2:=[profile?] <dev-haskell/tagged-0.9:=[profile?]
	>=dev-lang/ghc-7.4.1:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( >=dev-haskell/hspec-1.3 )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag big-endian big-endian) \
		$(cabal_flag force-endianness force-endianness) \
		$(cabal_flag reference reference)
}
