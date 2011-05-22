# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour"
inherit base haskell-cabal

DESCRIPTION="Graphviz bindings for Haskell."
HOMEPAGE="http://projects.haskell.org/graphviz/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMONDEPS=">=dev-lang/ghc-6.6.1
		=dev-haskell/colour-2.3*
		dev-haskell/extensible-exceptions
		=dev-haskell/fgl-5.4*
		=dev-haskell/polyparse-1.5*
		=dev-haskell/transformers-0.2*"

DEPEND="${COMMONDEPS}
		>=dev-haskell/cabal-1.6"

RDEPEND="${COMMONDEPS}
		media-gfx/graphviz"

PATCHES=("${FILESDIR}/graphviz-graphviz-2999.11.0.0-polyparse-1.5.patch")
