# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.6

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Javascript Object Signing and Encryption and JSON Web Token library"
HOMEPAGE="https://github.com/frasertweedale/hs-jose"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/aeson-0.8.0.1:=[profile?]
	dev-haskell/attoparsec:=[profile?]
	>=dev-haskell/base64-bytestring-1.0:=[profile?] <dev-haskell/base64-bytestring-1.1:=[profile?]
	>=dev-haskell/concise-0.1:=[profile?]
	>=dev-haskell/cryptonite-0.7:=[profile?]
	>=dev-haskell/lens-4.3:=[profile?]
	>=dev-haskell/memory-0.7:=[profile?]
	>=dev-haskell/monad-time-0.1:=[profile?]
	>=dev-haskell/mtl-2:=[profile?]
	>=dev-haskell/network-uri-2.6:=[profile?]
	>=dev-haskell/quickcheck-2:2=[profile?]
	dev-haskell/quickcheck-instances:=[profile?]
	>=dev-haskell/safe-0.3:=[profile?]
	>=dev-haskell/semigroups-0.15:=[profile?]
	>=dev-haskell/text-1.1:=[profile?]
	>=dev-haskell/unordered-containers-0.2:=[profile?] <dev-haskell/unordered-containers-0.3:=[profile?]
	dev-haskell/vector:=[profile?]
	>=dev-haskell/x509-1.4:=[profile?]
	>=dev-lang/ghc-7.10.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.22.2.0
	test? ( dev-haskell/hspec
		dev-haskell/tasty
		>=dev-haskell/tasty-hspec-1.0
		dev-haskell/tasty-quickcheck )
"
