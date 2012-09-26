# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal eutils

DESCRIPTION="A tiling window manager"
HOMEPAGE="http://xmonad.org"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/mtl
		>=dev-haskell/x11-1.4.6.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2
		<dev-haskell/cabal-1.14"

SAMPLE_CONFIG="xmonad.hs"
SAMPLE_CONFIG_LOC="man"

src_install() {
	cabal_src_install

	echo -e "#!/bin/sh\n/usr/bin/xmonad" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}"

	insinto /usr/share/xsessions
	doins "${FILESDIR}/${PN}.desktop"

	doman man/xmonad.1

	dodoc CONFIG README
}

pkg_postinst() {
	ghc-package_pkg_postinst

	elog "A sample ${SAMPLE_CONFIG} configuration file can be found here:"
	elog "    /usr/share/${PF}/ghc-$(ghc-version)/${SAMPLE_CONFIG_LOC}/${SAMPLE_CONFIG}"
	elog "The parameters in this file are the defaults used by xmonad."
	elog "To customize xmonad, copy this file to:"
	elog "    ~/.xmonad/${SAMPLE_CONFIG}"
	elog "After editing, use 'mod-q' to dynamically restart xmonad "
	elog "(where the 'mod' key defaults to 'Alt')."
	elog ""
	elog "Read the README or man page for more information, and to see "
	elog "other possible configurations go to:"
	elog "    http://haskell.org/haskellwiki/Xmonad/Config_archive"
	elog "Please note that many of these configurations will require the "
	elog "x11-wm/xmonad-contrib package to be installed."
}
