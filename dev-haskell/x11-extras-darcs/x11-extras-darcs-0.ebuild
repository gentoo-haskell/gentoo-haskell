# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib"

inherit haskell-cabal darcs autotools

DESCRIPTION="Missing bindings to the X11 graphics library"
HOMEPAGE="http://darcs.haskell.org/~sjanssen/X11-extras"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND=">=virtual/ghc-6.4
	>=dev-haskell/x11-1.2"

EDARCS_REPOSITORY="http://darcs.haskell.org/~sjanssen/X11-extras"
EDARCS_GET_CMD="get --partial"

src_compile() {
	eautoreconf
	cabal_src_compile
}
