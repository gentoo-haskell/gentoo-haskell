# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit gnome2 git

DESCRIPTION="Gnome applet for displaying XMonad log"
HOMEPAGE="http://uhsure.com/xmonad-log-applet.html"
SRC_URI=""
LICENSE="BSD"
EGIT_REPO_URI="http://git.uhsure.com/xmonad-log-applet.git"
EGIT_BOOTSTRAP="gnome2_src_prepare"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-apps/dbus
	gnome-base/gnome-panel
	dev-libs/glib:2
	dev-haskell/hdbus
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}"

src_configure() {
	econf --sysconfdir=/etc
}

src_install() {
	dodir /etc/gconf/schemas || dir "dodir failed"
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc "${FILESDIR}"/xmonad.hs || die
}

pkg_postinst() {
	elog "Remember to update your xmonad.hs accordingly"
	elog "a sample xmonad.hs is provided in /usr/share/doc/${PF}"
	elog "You can set the width of the applet via the"
	elog "/apps/xmonad-log-applet/width-chars gconf key"
}