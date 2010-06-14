# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Binding to the GNOME configuration database system."
HOMEPAGE="http://www.haskell.org/gtk2hs/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

BUILDTOOLS="dev-haskell/gtk2hs-buildtools"
HASKELLDEPS="=dev-haskell/glib-0.11*
		dev-haskell/mtl"
RDEPEND=">=dev-lang/ghc-6.10
		>=dev-libs/glib-2.20
		${HASKELLDEPS}"
DEPEND=">=dev-haskell/cabal-1.6
		${RDEPEND}
		${BUILDTOOLS}"
