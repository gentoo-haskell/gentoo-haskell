# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"

inherit haskell-cabal darcs savedconfig

DESCRIPTION="A lightweight X11 window manager"
HOMEPAGE="http://www.xmonad.org"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86"

IUSE="savedconfig"

DEPEND=">=virtual/ghc-6.4
	>=dev-haskell/x11-1.2.1
	dev-haskell/x11-extras-darcs
	~dev-haskell/mtl-1.0"

EDARCS_REPOSITORY="http://darcs.haskell.org/~sjanssen/xmonad"
EDARCS_GET_CMD="get --partial"

RESTRICT="strip"

S="${WORKDIR}/${PN}-${PV}"

src_unpack() {
	darcs_src_unpack

	cd "${S}"

	if use savedconfig; then
		restore_config Config.hs
	fi
}

src_install() {
	cabal_src_install

	mv "${D}/usr/bin/xmonad"{,-darcs}

	echo -e "#!/bin/sh\n/usr/bin/xmonad-darcs" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}"

	insinto /usr/share/xsessions
	doins "${FILESDIR}/${PN}.desktop"

	insinto /usr/share/${PN}
	newins Config.hs ${PF}.Config.hs
	save_config Config.hs
}
