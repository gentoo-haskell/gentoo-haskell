# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bnfc/bnfc-2.1.2.ebuild,v 1.3 2005/05/03 20:47:10 dholm Exp $

DESCRIPTION="BNF Converter -- a sophisticated parser generator"
HOMEPAGE="http://www.cs.chalmers.se/~markus/BNFC/"
SRC_URI="http://www.cs.chalmers.se/~markus/BNFC/${PN}_${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="doc"

DEPEND=">=virtual/ghc-6.2
	doc? ( virtual/tetex )"

RDEPEND="virtual/libc"

S="${WORKDIR}/BNFC"

src_unpack() {
	unpack ${A}
}

src_compile() {
	emake GHC_OPTS=-O || die "emake failed"
}

src_install() {
	dobin bnfc
	if use doc ; then
		cd doc
		pdflatex LBNF-report.tex
		pdflatex LBNF-report.tex
		dodoc LBNF-report.pdf
	fi
}
