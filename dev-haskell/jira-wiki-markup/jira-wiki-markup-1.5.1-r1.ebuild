# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.5.1.9999

CABAL_HACKAGE_REVISION=1

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Handle Jira wiki markup"
HOMEPAGE="https://github.com/tarleb/jira-wiki-markup"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/parsec-3.1:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-lang/ghc-9.0.2:=
	|| (
		( >=dev-haskell/text-1.1.1 <dev-haskell/text-1.3 )
		( >=dev-haskell/text-2.0 <dev-haskell/text-2.2 )
	)
	dev-haskell/text:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? ( dev-haskell/tasty
		dev-haskell/tasty-hunit )
"
