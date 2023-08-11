# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Powerful and easy command-line option parser"
HOMEPAGE="https://github.com/typeclasses/options/"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CABAL_CHDEPS=(
	'base ^>= 4.16 || ^>= 4.17 || ^>= 4.18' 'base >= 4.14 && < 5'
)

RDEPEND="
	>=dev-haskell/monads-tf-0.3:=[profile?] <dev-haskell/monads-tf-0.4:=[profile?]
	>=dev-lang/ghc-8.10.6:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.2.1.0
	test? (
		>=dev-haskell/hspec-2.9.7 <dev-haskell/hspec-2.12
		>=dev-haskell/patience-0.3 <dev-haskell/patience-0.4
	)
"
