# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib"
inherit haskell-cabal eutils

DESCRIPTION="GTK backend for the Yi editor"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/yi.html"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
	>=dev-haskell/gtk2hs-0.9.11
	>=dev-haskell/filepath-1.0
	dev-haskell/regex-posix"

pkg_setup() {
	if ! built_with_use dev-haskell/gtk2hs gnome; then
		eerror "yi-gtk requires the sourceview Haskell bindings. These"
		eerror "are provided by dev-haskell/gtk2hs only if built with"
		eerror "the gnome USE flag."
		eerror "Please re-emerge gtk2hs with USE=\"gnome\""
		die "yi-gtk requires gtk2hs to be built with USE=\"gnome\""
	fi
}
