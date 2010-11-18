# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit gnome2 git eutils

DESCRIPTION="Gnome applet for displaying XMonad log"
HOMEPAGE="http://uhsure.com/xmonad-log-applet.html"
SRC_URI=""
LICENSE="BSD"
EGIT_REPO_URI="http://git.uhsure.com/xmonad-log-applet.git"
EGIT_BOOTSTRAP="gnome2_src_prepare"

SLOT="0"
IUSE=""

RDEPEND="sys-apps/dbus
	gnome-base/gnome-panel
	dev-libs/glib:2
	dev-haskell/hdbus
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/Makefile.in.patch"
}

src_install() {
	emake DESTDIR="${D}"  install || die "Install failed"
	dodoc "${FILESDIR}"/xmonad.hs || die
}

pkg_postinst() {
	elog "Remember to update your xmonad.hs accordingly"
	elog "a sample xmonad.hs is provided in /usr/share/doc/${PF}"
}
