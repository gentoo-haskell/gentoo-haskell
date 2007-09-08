# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"

inherit haskell-cabal darcs savedconfig

DESCRIPTION="A lightweight X11 window manager"
HOMEPAGE="http://www.xmonad.org"
EDARCS_REPOSITORY="http://darcs.haskell.org/~sjanssen/xmonad"
XMONAD_REPOSITORY="${EDARCS_TOP_DIR}/xmonad"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="savedconfig extensions"

DEPEND=">=dev-lang/ghc-6.6
	>=dev-haskell/x11-1.2.1
	dev-haskell/x11-extras-darcs
	>=dev-haskell/mtl-1.0"
RDEPEND="${DEPEND}"

RESTRICT="strip"

fetch_XMonadContrib() {
	local EDARCS_REPOSITORY EDARCS_LOCALREPO
	EDARCS_REPOSITORY="http://darcs.haskell.org/~sjanssen/XMonadContrib"
	EDARCS_LOCALREPO="xmonad/XMonadContrib"
	darcs_fetch
}

delete_XMonadContrib() {
	if [ -d "${XMONAD_REPOSITORY}/XMonadContrib" ]; then
		rm -rf "${XMONAD_REPOSITORY}/XMonadContrib"
	fi
}

src_unpack() {
	darcs_src_unpack

	if use extensions; then
		fetch_XMonadContrib
	else
		delete_XMonadContrib
	fi

	cd "${S}"

	if use savedconfig; then
		restore_config Config.hs
	fi

	sed -i -e 's/unix>=1\.0/\0, readline>=1.0/' xmonad.cabal
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
