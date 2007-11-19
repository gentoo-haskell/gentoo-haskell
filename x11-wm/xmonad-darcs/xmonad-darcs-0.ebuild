# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin lib"

inherit haskell-cabal darcs

DESCRIPTION="A lightweight X11 window manager"
HOMEPAGE="http://www.xmonad.org/"
EDARCS_REPOSITORY="http://code.haskell.org/xmonad"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-haskell/mtl-1.0
	dev-haskell/x11-darcs
	>=dev-lang/ghc-6.6
	!x11-wm/xmonad"
RDEPEND="${DEPEND}"

RESTRICT="strip"

src_install() {
	cabal_src_install

	echo -e "#!/bin/sh\n/usr/bin/xmonad" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}"

	insinto /usr/share/xsessions
	doins "${FILESDIR}/${PN}.desktop"

	#requires one of the regex packages
	runhaskell util/GenerateManpage.hs
	doman man/xmonad.1
}
