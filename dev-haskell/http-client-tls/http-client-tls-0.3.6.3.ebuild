# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="http-client backend using the connection package and tls library"
HOMEPAGE="https://github.com/snoyberg/http-client"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RESTRICT=test # requires network access

RDEPEND="dev-haskell/case-insensitive:=[profile?]
	dev-haskell/crypton:=[profile?]
	dev-haskell/crypton-connection:=[profile?]
	dev-haskell/data-default-class:=[profile?]
	>=dev-haskell/http-client-0.7.11:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/memory:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/network-uri:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-haskell/tls-1.2:=[profile?]
	>=dev-lang/ghc-8.10.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.2.0.0
	test? ( dev-haskell/hspec )
"
