# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.6

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="automatical derivation of querying functions for servant webservices"
HOMEPAGE="http://haskell-servant.readthedocs.org/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/base-compat-0.10.1:=[profile?] <dev-haskell/base-compat-0.11:=[profile?]
	>=dev-haskell/exceptions-0.10.0:=[profile?] <dev-haskell/exceptions-0.11:=[profile?]
	>=dev-haskell/http-client-0.5.12:=[profile?] <dev-haskell/http-client-0.6:=[profile?]
	>=dev-haskell/http-media-0.7.1.2:=[profile?] <dev-haskell/http-media-0.8:=[profile?]
	>=dev-haskell/http-types-0.12.1:=[profile?] <dev-haskell/http-types-0.13:=[profile?]
	>=dev-haskell/monad-control-1.0.2.3:=[profile?] <dev-haskell/monad-control-1.1:=[profile?]
	>=dev-haskell/mtl-2.1:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/semigroupoids-5.2.2:=[profile?] <dev-haskell/semigroupoids-5.4:=[profile?]
	>=dev-haskell/semigroups-0.18.4:=[profile?] <dev-haskell/semigroups-0.19:=[profile?]
	>=dev-haskell/servant-client-core-0.14:=[profile?] <dev-haskell/servant-client-core-0.15:=[profile?]
	>=dev-haskell/stm-2.4.5.0:=[profile?] <dev-haskell/stm-2.5:=[profile?]
	>=dev-haskell/text-1.2.3.0:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-haskell/transformers-base-0.4.5.2:=[profile?] <dev-haskell/transformers-base-0.5:=[profile?]
	>=dev-haskell/transformers-compat-0.6.2:=[profile?] <dev-haskell/transformers-compat-0.7:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( dev-haskell/aeson
		>=dev-haskell/generics-sop-0.3.2.0 <dev-haskell/generics-sop-0.4
		>=dev-haskell/hspec-2.5.1 <dev-haskell/hspec-2.6
		dev-haskell/http-api-data
		>=dev-haskell/hunit-1.6 <dev-haskell/hunit-1.7
		dev-haskell/markdown-unlit
		>=dev-haskell/network-2.6.3.2 <dev-haskell/network-2.8
		>=dev-haskell/quickcheck-2.10.1 <dev-haskell/quickcheck-2.12
		>=dev-haskell/servant-0.14 <dev-haskell/servant-0.15
		>=dev-haskell/servant-server-0.14 <dev-haskell/servant-server-0.15
		dev-haskell/wai
		dev-haskell/warp )
"
