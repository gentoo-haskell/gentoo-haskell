# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="An implementation of the Jinja2 template language in Haskell"
HOMEPAGE="https://ginger.tobiasdammers.nl/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

# https://github.com/tdammers/ginger/issues/64
RESTRICT=test # fails at least on recursive loop test

RDEPEND=">=dev-haskell/aeson-1.4.2.0:=[profile?] <dev-haskell/aeson-1.6:=[profile?]
	>=dev-haskell/aeson-pretty-0.8.7:=[profile?] <dev-haskell/aeson-pretty-0.9:=[profile?]
	>=dev-haskell/data-default-0.5:=[profile?]
	>=dev-haskell/http-types-0.8:=[profile?]
	>=dev-haskell/mtl-2.2:=[profile?]
	>=dev-haskell/optparse-applicative-0.14.3.0:=[profile?] <dev-haskell/optparse-applicative-0.17:=[profile?]
	>=dev-haskell/parsec-3.0:=[profile?]
	>=dev-haskell/regex-tdfa-1.2.3:=[profile?] <=dev-haskell/regex-tdfa-1.5:=[profile?]
	>=dev-haskell/safe-0.3:=[profile?]
	>=dev-haskell/scientific-0.3:=[profile?]
	>=dev-haskell/text-1.2.3.1:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-haskell/unordered-containers-0.2.5:=[profile?]
	>=dev-haskell/utf8-string-1.0.1.1:=[profile?] <dev-haskell/utf8-string-1.1:=[profile?]
	>=dev-haskell/vector-0.12.0.2:=[profile?] <dev-haskell/vector-0.13:=[profile?]
	>=dev-haskell/yaml-0.11.0.0:=[profile?] <dev-haskell/yaml-0.12:=[profile?]
	>=dev-lang/ghc-8.6.5:=
	>=dev-haskell/http-types-0.12:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.4.0.1
	test? ( >=dev-haskell/mtl-2.2.2 <dev-haskell/mtl-2.3
		>=dev-haskell/tasty-1.2 <dev-haskell/tasty-1.3
		>=dev-haskell/tasty-hunit-0.10.0.1 <dev-haskell/tasty-hunit-0.11
		>=dev-haskell/tasty-quickcheck-0.10 <dev-haskell/tasty-quickcheck-0.11 )
"
