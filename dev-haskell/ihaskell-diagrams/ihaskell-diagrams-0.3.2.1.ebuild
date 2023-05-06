# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.1

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="IHaskell display instances for diagram types"
HOMEPAGE="http://www.github.com/gibiansky/ihaskell"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-haskell/active-0.2:=[profile?]
	>=dev-haskell/diagrams-1.3:=[profile?]
	dev-haskell/diagrams-cairo:=[profile?]
	dev-haskell/diagrams-lib:=[profile?]
	>=dev-haskell/ihaskell-0.6.2:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-lang/ghc-7.6.1:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.16.0
"
