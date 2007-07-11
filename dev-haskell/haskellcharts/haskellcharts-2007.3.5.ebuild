# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $


CABAL_FEATURES="lib haddock"
inherit haskell-cabal

MY_PN=Chart
MY_P=${MY_PN}-${PV}

DESCRIPTION="A library for rendering 2D charts from haskell."
HOMEPAGE="http://dockerz.net/twd/HaskellCharts"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4
	>=dev-haskell/gtk2hs-0.9.11"

S="${WORKDIR}/${MY_P}"