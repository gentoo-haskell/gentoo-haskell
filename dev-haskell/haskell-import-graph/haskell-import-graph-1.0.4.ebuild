# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="create haskell import graph for graphviz"
HOMEPAGE="https://github.com/ncaq/haskell-import-graph#readme"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="dev-haskell/classy-prelude:=[profile?]
	dev-haskell/graphviz:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-lang/ghc-7.10.1:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.22.2.0
"
