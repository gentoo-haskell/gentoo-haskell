# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Extensible Haskell pretty printer"
HOMEPAGE="https://github.com/mihaimaruseac/hindent"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/async-2.2.5:=[profile?]
	<dev-haskell/cabal-3.12:=[profile?]
	>=dev-haskell/ghc-lib-parser-9.2:=[profile?] <dev-haskell/ghc-lib-parser-9.11:=[profile?]
	dev-haskell/ghc-lib-parser-ex:=[profile?]
	dev-haskell/monad-loops:=[profile?]
	dev-haskell/optparse-applicative:=[profile?]
	dev-haskell/path:=[profile?]
	dev-haskell/path-io:=[profile?]
	dev-haskell/regex-tdfa:=[profile?]
	dev-haskell/split:=[profile?]
	dev-haskell/syb:=[profile?]
	dev-haskell/unicode-show:=[profile?]
	dev-haskell/utf8-string:=[profile?]
	dev-haskell/yaml:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? ( dev-haskell/diff
		dev-haskell/hspec )
"
