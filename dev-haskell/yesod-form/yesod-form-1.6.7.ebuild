# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.2

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Form handling support for Yesod Web Framework"
HOMEPAGE="http://www.yesodweb.com/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+network-uri"

RDEPEND="dev-haskell/aeson:=[profile?]
	>=dev-haskell/attoparsec-0.10:=[profile?]
	>=dev-haskell/blaze-builder-0.2.1.4:=[profile?]
	>=dev-haskell/blaze-html-0.5:=[profile?]
	>=dev-haskell/blaze-markup-0.5.1:=[profile?]
	dev-haskell/byteable:=[profile?]
	dev-haskell/data-default:=[profile?]
	>=dev-haskell/email-validate-1.0:=[profile?]
	dev-haskell/persistent:=[profile?]
	dev-haskell/resourcet:=[profile?]
	dev-haskell/semigroups:=[profile?]
	>=dev-haskell/shakespeare-2.0:=[profile?]
	>=dev-haskell/text-0.9:=[profile?]
	>=dev-haskell/wai-1.3:=[profile?]
	>=dev-haskell/xss-sanitize-0.3.0.1:=[profile?]
	>=dev-haskell/yesod-core-1.6:=[profile?] <dev-haskell/yesod-core-1.7:=[profile?]
	>=dev-haskell/yesod-persistent-1.6:=[profile?] <dev-haskell/yesod-persistent-1.7:=[profile?]
	>=dev-lang/ghc-7.8.2:=
	network-uri? ( >=dev-haskell/network-uri-2.6:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( dev-haskell/hspec )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag network-uri network-uri)
}
