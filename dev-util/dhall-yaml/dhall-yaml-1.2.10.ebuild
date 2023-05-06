# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Convert between Dhall and YAML"
HOMEPAGE="https://dhall-lang.org/
	https://hackage.haskell.org/package/dhall-yaml"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/aeson-1.0.0.0:=[profile?] <dev-haskell/aeson-2.1:=[profile?]
	>=dev-haskell/ansi-terminal-0.6.3.1:=[profile?] <dev-haskell/ansi-terminal-0.12:=[profile?]
	>=dev-haskell/hsyaml-0.2:=[profile?] <dev-haskell/hsyaml-0.3:=[profile?]
	>=dev-haskell/hsyaml-aeson-0.2:=[profile?] <dev-haskell/hsyaml-aeson-0.3:=[profile?]
	>=dev-haskell/optparse-applicative-0.14.0.0:=[profile?] <dev-haskell/optparse-applicative-0.18:=[profile?]
	>=dev-haskell/prettyprinter-1.7.0:=[profile?]
	>=dev-haskell/prettyprinter-ansi-terminal-1.1.1:=[profile?] <dev-haskell/prettyprinter-ansi-terminal-1.2:=[profile?]
	dev-haskell/vector:=[profile?]
	>=dev-lang/dhall-1.31.0:=[profile?] <dev-lang/dhall-1.42:=[profile?]
	>=dev-lang/ghc-8.10.1:=[profile?]
	>=dev-util/dhall-json-1.6.0:=[profile?] <dev-util/dhall-json-1.8:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.2.0.0
	test? ( <dev-haskell/tasty-1.5
		<dev-haskell/tasty-expected-failure-0.13
		>=dev-haskell/tasty-hunit-0.2 )
"
