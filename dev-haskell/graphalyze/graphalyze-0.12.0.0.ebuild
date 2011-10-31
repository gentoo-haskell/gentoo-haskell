# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit base haskell-cabal

MY_PN="Graphalyze"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Graph-Theoretic Analysis library."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/Graphalyze"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON=">=dev-lang/ghc-6.8.1
		<dev-haskell/bktrees-0.4
		dev-haskell/extensible-exceptions
		=dev-haskell/fgl-5.4*
		=dev-haskell/graphviz-2999.12*
		=app-text/pandoc-1.8*
		dev-haskell/text
		dev-haskell/time"
DEPEND="${COMMON}
		>=dev-haskell/cabal-1.6"
RDEPEND="${COMMON}
		media-gfx/graphviz"

S="${WORKDIR}/${MY_P}"

PATCHES=("${FILESDIR}/${P}-ghc-7.2.patch")
