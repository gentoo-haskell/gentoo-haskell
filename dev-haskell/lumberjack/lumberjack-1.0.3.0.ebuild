# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999

CABAL_HACKAGE_REVISION=2

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Trek through your code forest and make logs"
HOMEPAGE="https://github.com/GaloisInc/lumberjack"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/contravariant-1.5:=[profile?] <dev-haskell/contravariant-1.6:=[profile?]
	>=dev-haskell/prettyprinter-1.6:=[profile?] <dev-haskell/prettyprinter-1.8:=[profile?]
	>=dev-haskell/prettyprinter-ansi-terminal-1.1.1.2:=[profile?] <dev-haskell/prettyprinter-ansi-terminal-1.2:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
"
