# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Visualize live Haskell data structures using vacuum, graphviz and cairo"
HOMEPAGE="http://code.haskell.org/~dons/code/vacuum-cairo"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		dev-haskell/parallel
		dev-haskell/strict-concurrency
		dev-haskell/cairo
		dev-haskell/gtk
		dev-haskell/svgcairo
		>=dev-haskell/vacuum-0.0.5.1
		media-gfx/graphviz"
