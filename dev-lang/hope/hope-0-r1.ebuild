# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

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
	default

	sed -i "s|/usr/local|/usr|" src/hopelib.h || die

	# getline() collides with glibc-2.10:getline()
	sed -i 's|getline|get_line|g' \
		"${S}"/src/{source.c,source.h,yylex.c} || die

	# disable stripping
	sed -i 's|$(INSTALL_PROGRAM) -s|$(INSTALL_PROGRAM)|g' \
		"${S}"/src/Makefile.in || die

	use doc || sed -i "s|doc ||" Makefile
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1

	emake install \
		prefix="${ED}/usr" \
		docdir="${ED}/usr/share/doc/${PF}" \
		hopelib="${ED}/usr/share/hope/lib" \
		mandir="${ED}/usr/share/man/man1"
}
