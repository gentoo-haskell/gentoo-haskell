# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A documentation-generation tool for Haskell libraries"
HOMEPAGE="http://www.haskell.org/haddock/"
#SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"
SRC_URI="http://dev.gentoo.org/~gienah/snapshots/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS=""
IUSE=""

RESTRICT=test

RDEPEND=">=dev-haskell/cabal-1.10:=[profile?]
	dev-haskell/ghc-paths:=[profile?]
	>=dev-haskell/haddock-library-1.4.0:=[profile?] <dev-haskell/haddock-library-1.5:=[profile?]
	>=dev-haskell/xhtml-3000.2:=[profile?] <dev-haskell/xhtml-3000.3:=[profile?]
	>=dev-lang/ghc-7.8.0:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
"
