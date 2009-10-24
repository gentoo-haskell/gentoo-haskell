# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

MY_PN="Monadius"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="2-D arcade scroller"
HOMEPAGE="http://www.geocities.jp/takascience/haskell/monadius_en.html"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/cabal
		dev-haskell/glut
		dev-haskell/opengl"

S="${WORKDIR}/${MY_P}"
