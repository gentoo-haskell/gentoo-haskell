# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools gnome2

DESCRIPTION="Gnome and XFCE applet for displaying XMonad log"
HOMEPAGE="https://github.com/alexkay/xmonad-log-applet"
SRC_URI="https://github.com/downloads/alexkay/xmonad-log-applet/xmonad-log-applet-2.0.0.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gnome2 gnome3 xfce4"

RESTRICT="mirror"

RDEPEND="sys-apps/dbus
	gnome2? ( gnome-base/gnome-panel )
	gnome3? ( >=gnome-base/gnome-panel-3.0.2 )
	xfce4? ( xfce-base/xfce4-panel )
	dev-libs/glib:2
	dev-haskell/hdbus
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	local myconf
	myconf=""

	if use gnome2; then
		myconf="${myconf} --with-panel=gnome2"
	fi
	if use gnome3; then
		myconf="${myconf} --with-panel=gnome3"
	fi
	if use xfce4; then
		myconf="${myconf} --with-panel=xfce4"
	fi

	econf --sysconfdir=/etc ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS.md README.md
	dodoc "${FILESDIR}"/xmonad.hs
}

pkg_postinst() {
	elog "Remember to update your xmonad.hs accordingly"
	elog "a sample xmonad.hs is provided in /usr/share/doc/${PF}"
}
