# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.2.9999
#hackport: flags: -developer,+network-uri

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="a Haskell client for the Selenium WebDriver protocol"
HOMEPAGE="https://github.com/kallisti-dev/hs-webdriver"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/aeson-0.6.2.0:=[profile?]
	>=dev-haskell/attoparsec-0.10:=[profile?]
	>=dev-haskell/base64-bytestring-1.0:=[profile?]
	dev-haskell/data-default-class:=[profile?]
	>=dev-haskell/directory-tree-0.11:=[profile?]
	>=dev-haskell/exceptions-0.4:=[profile?]
	>=dev-haskell/http-client-0.3:=[profile?]
	>=dev-haskell/http-types-0.8:=[profile?]
	>=dev-haskell/lifted-base-0.1:=[profile?]
	>=dev-haskell/monad-control-0.3:=[profile?]
	>=dev-haskell/network-2.6:=[profile?]
	>=dev-haskell/network-uri-2.6:=[profile?]
	>=dev-haskell/scientific-0.2:=[profile?]
	>=dev-haskell/temporary-1.0:=[profile?]
	>=dev-haskell/text-0.11.3:=[profile?]
	>=dev-haskell/transformers-base-0.1:=[profile?]
	>=dev-haskell/unordered-containers-0.1.3:=[profile?]
	>=dev-haskell/vector-0.3:=[profile?]
	>=dev-haskell/zip-archive-0.1.1.8:=[profile?]
	>=dev-lang/ghc-7.10.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.22.2.0
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=-developer \
		--flag=network-uri
}
