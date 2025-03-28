# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Set breakpoints using a GHC plugin"
HOMEPAGE="https://hackage.haskell.org/package/breakpoint"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/ansi-terminal-1.0:=[profile?] <dev-haskell/ansi-terminal-2.0:=[profile?]
	>=dev-haskell/haskeline-0.8.2:=[profile?] <dev-haskell/haskeline-0.9:=[profile?]
	>=dev-haskell/pretty-simple-4.1.2:=[profile?] <dev-haskell/pretty-simple-4.2:=[profile?]
	>=dev-haskell/text-1.2.5:=[profile?] <dev-haskell/text-2.2:=[profile?]
	>=dev-lang/ghc-9.2.4:=
	>=dev-lang/ghc-9.4.0:=[profile?] <dev-lang/ghc-9.11:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.6.3.0
	test? ( dev-haskell/tasty
		dev-haskell/tasty-hunit )
"
