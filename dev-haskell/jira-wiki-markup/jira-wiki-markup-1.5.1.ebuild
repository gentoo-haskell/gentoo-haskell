# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.2.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Handle Jira wiki markup"
HOMEPAGE="https://github.com/tarleb/jira-wiki-markup"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/parsec-3.1:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-lang/ghc-8.8.1:=[profile?]
	>=dev-haskell/text-1.1.1:=[profile?] <dev-haskell/text-2.1:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.0.0.0
	test? ( dev-haskell/tasty
		dev-haskell/tasty-hunit )
"
