# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="CSS Minifier"
HOMEPAGE="https://github.com/contivero/hasmin#readme"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT=test # one of two test suites fails

RDEPEND=">=dev-haskell/attoparsec-0.12:=[profile?] <dev-haskell/attoparsec-0.14:=[profile?]
	>=dev-haskell/gitrev-1.0.0:=[profile?] <dev-haskell/gitrev-1.4:=[profile?]
	>=dev-haskell/hopfli-0.2:=[profile?] <dev-haskell/hopfli-0.4:=[profile?]
	>=dev-haskell/matrix-0.3.4:=[profile?] <dev-haskell/matrix-0.4:=[profile?]
	>=dev-haskell/mtl-2.2.1:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/numbers-3000.2.0.0:=[profile?] <dev-haskell/numbers-3000.3:=[profile?]
	>=dev-haskell/optparse-applicative-0.11:=[profile?] <dev-haskell/optparse-applicative-0.16:=[profile?]
	>=dev-haskell/parsers-0.12.3:=[profile?] <dev-haskell/parsers-0.13:=[profile?]
	>=dev-haskell/text-1.2:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-lang/ghc-8.2.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.0.0.2
	test? ( >=dev-haskell/doctest-0.11 <dev-haskell/doctest-0.17
		>=dev-haskell/doctest-discover-0.1.0.0 <dev-haskell/doctest-discover-0.3
		>=dev-haskell/hspec-2.2 <dev-haskell/hspec-3.0
		>=dev-haskell/hspec-attoparsec-0.1.0.0 <dev-haskell/hspec-attoparsec-0.2
		>=dev-haskell/quickcheck-2.8 <dev-haskell/quickcheck-3.0
		>=dev-haskell/quickcheck-instances-0.3.16 <dev-haskell/quickcheck-instances-0.4 )
"

src_prepare() {
	default

	cabal_chdeps \
		'optparse-applicative >=0.11       && <0.15' 'optparse-applicative >=0.11'
}
