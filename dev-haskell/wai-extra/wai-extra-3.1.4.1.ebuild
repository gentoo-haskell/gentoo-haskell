# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6.9999
#hackport: flags: build-example:examples

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Provides some basic WAI handlers and middleware"
HOMEPAGE="https://github.com/yesodweb/wai"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/ansi-terminal:=[profile?]
	dev-haskell/base64-bytestring:=[profile?]
	dev-haskell/call-stack:=[profile?]
	>=dev-haskell/case-insensitive-0.2:=[profile?]
	dev-haskell/cookie:=[profile?]
	dev-haskell/data-default-class:=[profile?]
	>=dev-haskell/fast-logger-2.4.5:=[profile?]
	>=dev-haskell/http-types-0.7:=[profile?]
	dev-haskell/http2:=[profile?]
	dev-haskell/hunit:=[profile?]
	dev-haskell/iproute:=[profile?]
	>=dev-haskell/network-2.6.1.0:=[profile?]
	>=dev-haskell/old-locale-1.0.0.2:=[profile?] <dev-haskell/old-locale-1.1:=[profile?]
	>=dev-haskell/resourcet-0.4.6:=[profile?] <dev-haskell/resourcet-1.3:=[profile?]
	>=dev-haskell/streaming-commons-0.2:=[profile?]
	>=dev-haskell/text-0.7:=[profile?]
	dev-haskell/unix-compat:=[profile?]
	dev-haskell/vault:=[profile?]
	>=dev-haskell/void-0.5:=[profile?]
	>=dev-haskell/wai-3.0.3.0:=[profile?] <dev-haskell/wai-3.3:=[profile?]
	>=dev-haskell/wai-logger-2.3.2:=[profile?]
	dev-haskell/word8:=[profile?]
	dev-haskell/zlib:=[profile?]
	>=dev-lang/ghc-8.2.1:=
	examples? ( dev-haskell/warp:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.0.0.2
	test? ( >=dev-haskell/hspec-1.3 )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag examples build-example)
}
