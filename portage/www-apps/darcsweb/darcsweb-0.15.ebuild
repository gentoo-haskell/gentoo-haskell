# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit webapp

DESCRIPTION="A web interface for darcs"
HOMEPAGE="http://users.auriga.wearlab.de/~alb/darcsweb/"
SRC_URI="http://users.auriga.wearlab.de/~alb/darcsweb/files/${PV}/${P}.tar.bz2"

LICENSE="public-domain"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-util/darcs
	dev-lang/python"

src_install() {
	webapp_src_preinst
	dodoc README

	chmod +x darcsweb.cgi

	cp style.css ${D}${MY_HTDOCSDIR}
	cp darcsweb.cgi ${D}${MY_HTDOCSDIR}
	cp minidarcs.png ${D}${MY_HTDOCSDIR}
	cp darcs.png ${D}${MY_HTDOCSDIR}
	cp config.py.sample ${D}${MY_HTDOCSDIR}
	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst
	ewarn "You must copy config.py.sample to config.py and edit it to get it working."
	ewarn "If you're using apache, be sure that \"Options ExecCGI\" and"
	ewarn "\"AddHandler cgi-script .cgi\" are in your server config."
}
