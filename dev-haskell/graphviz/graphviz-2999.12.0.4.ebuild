# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:	$

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="Graphviz bindings for Haskell."
HOMEPAGE="http://projects.haskell.org/graphviz/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

COMMONDEPS=">=dev-lang/ghc-6.10.1
		=dev-haskell/colour-2.3*
		=dev-haskell/dlist-0.5*
		dev-haskell/extensible-exceptions
		=dev-haskell/fgl-5.4*
		=dev-haskell/polyparse-1.7*
		dev-haskell/text
		=dev-haskell/transformers-0.2*
		dev-haskell/wl-pprint-text"

DEPEND="${COMMONDEPS}
		>=dev-haskell/cabal-1.6
		test? ( >=dev-haskell/quickcheck-2.3:2
		)
		"

RDEPEND="${COMMONDEPS}
		media-gfx/graphviz"

src_configure() {
	cabal_src_configure $(cabal_flag test)
}
