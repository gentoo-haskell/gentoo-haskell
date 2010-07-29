# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"

CABAL_FEATURES="lib profile haddock hscolour"

inherit base haskell-cabal

DESCRIPTION="Binding to the Gtk+ graphical user interface library."
HOMEPAGE="http://www.haskell.org/gtk2hs/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.10
		=dev-haskell/cairo-0.11*
		=dev-haskell/gio-0.11*
		=dev-haskell/glib-0.11*
		dev-haskell/mtl
		=dev-haskell/pango-0.11*
		dev-libs/glib:2
		x11-libs/gtk+:2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6.0
		dev-haskell/gtk2hs-buildtools"

PATCHES=( "${FILESDIR}/gtk-0.11.0-utf8.patch" )
