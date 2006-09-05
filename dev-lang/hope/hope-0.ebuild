# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/hugs98/hugs98-2005.3.ebuild,v 1.2 2005/03/19 12:34:14 kosmikus Exp $

DESCRIPTION="A lazy interpreter for the small functional programming language Hope"
SRC_URI="http://www.soi.city.ac.uk/~ross/Hope/${PN}.tar.gz"
HOMEPAGE="http://www.soi.city.ac.uk/~ross/Hope"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"
IUSE="doc"

DEPEND="virtual/libc
	doc? ( virtual/tetex dev-tex/latex2html )"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s|/usr/local|/usr|" src/hopelib.h
	use doc || sed -i "s|doc ||" Makefile
}

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install () {
	dodir /usr/bin
	einstall \
		hopelib="${D}/usr/share/hope/lib" \
		docdir="${D}/usr/share/doc/${PF}" \
		|| die "make install failed"
}

