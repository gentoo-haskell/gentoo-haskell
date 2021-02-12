# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.1

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="JSON quasiquoter for Haskell"
HOMEPAGE="https://github.com/sol/aeson-qq#readme"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/aeson-0.6:=[profile?]
	dev-haskell/attoparsec:=[profile?]
	dev-haskell/base-compat:=[profile?]
	>=dev-haskell/haskell-src-meta-0.1.0:=[profile?]
	dev-haskell/parsec:=[profile?]
	dev-haskell/scientific:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/vector:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.12
	test? ( dev-haskell/hspec )
"
