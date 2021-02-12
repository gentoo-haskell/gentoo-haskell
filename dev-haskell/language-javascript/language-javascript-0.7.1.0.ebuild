# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Parser for JavaScript"
HOMEPAGE="https://github.com/erikd/language-javascript"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/blaze-builder-0.2:=[profile?]
	>=dev-haskell/mtl-1.1:=[profile?]
	>=dev-haskell/semigroups-0.16.1:=[profile?]
	>=dev-haskell/text-1.2:=[profile?]
	>=dev-haskell/utf8-string-0.3.7:=[profile?] <dev-haskell/utf8-string-2:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	dev-haskell/alex
	>=dev-haskell/cabal-1.9.2
	dev-haskell/happy
	test? ( dev-haskell/hspec
		>=dev-haskell/quickcheck-2
		>=dev-haskell/utf8-light-0.4 )
"
