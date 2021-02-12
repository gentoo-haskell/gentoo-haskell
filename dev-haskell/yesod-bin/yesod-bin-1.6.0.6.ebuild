# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6.9999

CABAL_FEATURES=""
inherit haskell-cabal

DESCRIPTION="The yesod helper executable"
HOMEPAGE="http://www.yesodweb.com/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/cabal-1.18:=
	>=dev-haskell/conduit-1.3:=
	>=dev-haskell/conduit-extra-1.3:=
	dev-haskell/data-default-class:=
	dev-haskell/file-embed:=
	>=dev-haskell/fsnotify-0.0:= <dev-haskell/fsnotify-0.4:=
	>=dev-haskell/http-client-0.4.7:=
	dev-haskell/http-client-tls:=
	>=dev-haskell/http-reverse-proxy-0.4:=
	>=dev-haskell/http-types-0.7:=
	>=dev-haskell/network-2.5:=
	>=dev-haskell/optparse-applicative-0.11:=
	>=dev-haskell/project-template-0.1.1:=
	dev-haskell/say:=
	>=dev-haskell/split-0.2:= <dev-haskell/split-0.3:=
	dev-haskell/stm:=
	dev-haskell/streaming-commons:=
	>=dev-haskell/tar-0.4:= <dev-haskell/tar-0.6:=
	>=dev-haskell/text-0.11:=
	dev-haskell/transformers-compat:=
	dev-haskell/unliftio:=
	dev-haskell/unordered-containers:=
	>=dev-haskell/wai-2.0:=
	dev-haskell/wai-extra:=
	>=dev-haskell/warp-1.3.7.5:=
	>=dev-haskell/warp-tls-3.0.1:=
	>=dev-haskell/yaml-0.8:= <dev-haskell/yaml-0.12:=
	>=dev-haskell/zlib-0.5:=
	>=dev-lang/ghc-8.2.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.0.0.2
"
