# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="BSON documents are JSON-like objects with a standard binary encoding"
HOMEPAGE="https://github.com/mongodb-haskell/bson"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="old-network"

RDEPEND=">=dev-haskell/cryptohash-md5-0.11:=[profile?] <dev-haskell/cryptohash-md5-0.12:=[profile?]
	dev-haskell/data-binary-ieee754:=[profile?]
	>=dev-haskell/mtl-2:=[profile?]
	>=dev-haskell/text-0.11:=[profile?]
	>=dev-lang/ghc-7.4.1:=
	old-network? ( <dev-haskell/network-2.9:=[profile?] )
	!old-network? ( >=dev-haskell/network-bsd-2.7:=[profile?] <dev-haskell/network-bsd-2.9:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( >=dev-haskell/quickcheck-2.4
		>=dev-haskell/test-framework-0.4
		>=dev-haskell/test-framework-quickcheck2-0.2 )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag old-network _old-network)
}
