# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/hugs98/hugs98-2005.3.ebuild,v 1.2 2005/03/19 12:34:14 kosmikus Exp $

EAPI="3"

DESCRIPTION="A lazy interpreter for the small functional programming language Hope"
SRC_URI="http://www.soi.city.ac.uk/~ross/Hope/${PN}.tar.gz"
HOMEPAGE="http://www.soi.city.ac.uk/~ross/Hope"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE="doc"

# dev-texlive/texlive-latexextra contains a4wide.sty
DEPEND="doc? ( virtual/latex-base
		dev-tex/latex2html
		dev-texlive/texlive-latexextra
	)
	"
RDEPEND=""

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i "s|/usr/local|/usr|" src/hopelib.h

	# getline() collides with glibc-2.10:getline()
	sed -i 's|getline|get_line|g' \
		"${S}"/src/{source.c,source.h,yylex.c}

	# disable stripping
	sed -i 's|$(INSTALL_PROGRAM) -s|$(INSTALL_PROGRAM)|g' \
		"${S}"/src/Makefile.in

	use doc || sed -i "s|doc ||" Makefile
}

src_install() {
	dodir /usr/bin
	# otherwise it will create 'usr/share/man' file
	mkdir -p "${D}/usr/share/man" || die
	einstall \
		hopelib="${D}/usr/share/hope/lib" \
		docdir="${D}/usr/share/doc/${PF}" \
		|| die "make install failed"
}
