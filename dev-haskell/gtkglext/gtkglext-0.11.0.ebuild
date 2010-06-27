# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Binding to the GTK+ OpenGL Extension"
HOMEPAGE="http://www.haskell.org/gtk2hs/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-haskell/cairo-0.11*
		=dev-haskell/glib-0.11*
		=dev-haskell/gtk-0.11*
		dev-haskell/mtl
		=dev-haskell/pango-0.11*
		>=dev-lang/ghc-6.8.1
		>=x11-libs/gtkglext-1.0.5"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6.0
		dev-haskell/gtk2hs-buildtools"

