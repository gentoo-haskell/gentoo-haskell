# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Binding to the Cairo library."
HOMEPAGE="http://www.haskell.org/gtk2hs/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

BUILDTOOLS="dev-haskell/gtk2hs-buildtools"
HASKELLDEPS="dev-haskell/mtl"
RDEPEND=">=dev-lang/ghc-6.10
		x11-libs/cairo[svg]
		${HASKELLDEPS}"
DEPEND=">=dev-haskell/cabal-1.6.0
		${RDEPEND}
		${BUILDTOOLS}"
