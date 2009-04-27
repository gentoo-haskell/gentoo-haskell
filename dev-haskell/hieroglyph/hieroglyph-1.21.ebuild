# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib haddock hscolour"
inherit haskell-cabal

MY_PN="Hieroglyph"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Purely functional 2D drawing"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/Hieroglyph"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		dev-haskell/colour
		dev-haskell/gtk2hs
		dev-haskell/ifelse
		dev-haskell/mtl
		dev-haskell/parallel"

S="${WORKDIR}/${MY_P}"
