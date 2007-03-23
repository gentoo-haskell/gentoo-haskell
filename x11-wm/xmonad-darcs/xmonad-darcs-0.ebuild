# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"

inherit haskell-cabal darcs

DESCRIPTION="A lightweight X11 window manager"
HOMEPAGE="http://darcs.haskell.org/~sjanssen/xmonad"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND=">=virtual/ghc-6.4
	>=dev-haskell/x11-1.1
	dev-haskell/x11-extras-darcs
	~dev-haskell/mtl-1.0"

EDARCS_REPOSITORY="http://darcs.haskell.org/~sjanssen/xmonad"
EDARCS_GET_CMD="get --partial --verbose"
