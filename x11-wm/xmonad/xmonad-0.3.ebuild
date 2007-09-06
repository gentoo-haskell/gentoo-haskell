# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"

inherit base haskell-cabal savedconfig

DESCRIPTION="A lightweight X11 window manager"
HOMEPAGE="http://www.xmonad.org"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="savedconfig"

DEPEND=">=dev-lang/ghc-6.4
	>=dev-haskell/x11-1.2.1
	>=dev-haskell/x11-extras-0.2
	>=dev-haskell/mtl-1.0"

RESTRICT="strip"

src_unpack() {
	base_src_unpack

	cd "${S}"
	if use savedconfig; then
		restore_config Config.hs
	fi

	echo '> import Distribution.Simple' > "${S}/Setup.lhs"
	echo '> main = defaultMain' >> "${S}/Setup.lhs"
}

src_install() {
	cabal_src_install

	echo -e "#!/bin/sh\n/usr/bin/xmonad" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}"

	insinto /usr/share/xsessions
	doins "${FILESDIR}/${PN}.desktop"

	insinto /usr/share/${PN}
	newins Config.hs ${PF}.Config.hs
	save_config Config.hs
}
