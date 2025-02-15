# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A Haskell Language Server plugin that qualifies imported names"
HOMEPAGE="https://hackage.haskell.org/package/hls-qualify-imported-names-plugin"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CABAL_CHDEPS=(
	'ghcide                == 2.6.0.0' 'ghcide >= 2.6.0.0'
	'hls-plugin-api        == 2.6.0.0' 'hls-plugin-api >= 2.6.0.0'
	'hls-test-utils             == 2.6.0.0' 'hls-test-utils >= 2.6.0.0'
	)

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/dlist:=[profile?]
	>=dev-haskell/ghcide-2.6.0.0:=[profile?]
	dev-haskell/hls-graph:=[profile?]
	>=dev-haskell/hls-plugin-api-2.6.0.0:=[profile?]
	dev-haskell/lens:=[profile?]
	dev-haskell/lsp:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	>=dev-lang/ghc-9.0.2:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? ( >=dev-haskell/hls-test-utils-2.6.0.0 )
"
