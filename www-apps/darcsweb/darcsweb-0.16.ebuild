# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit webapp

DESCRIPTION="A web interface for darcs"
HOMEPAGE="http://users.auriga.wearlab.de/~alb/darcsweb/"
SRC_URI="http://users.auriga.wearlab.de/~alb/darcsweb/files/${PV}/${P}.tar.bz2"

LICENSE="public-domain"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-vcs/darcs
	dev-lang/python"

src_install() {
	webapp_src_preinst
	dodoc README
	newbin mkconfig.py darcsweb-mkconfig.py

	chmod +x darcsweb.cgi

	cp style.css "${D}${MY_HTDOCSDIR}"
	cp darcsweb.cgi "${D}${MY_HTDOCSDIR}"
	cp minidarcs.png "${D}${MY_HTDOCSDIR}"
	cp darcs.png "${D}${MY_HTDOCSDIR}"
	cp config.py.sample "${D}${MY_HTDOCSDIR}"
	webapp_postinst_txt en "${FILESDIR}/postinstall-en.txt"
	webapp_src_install
}
