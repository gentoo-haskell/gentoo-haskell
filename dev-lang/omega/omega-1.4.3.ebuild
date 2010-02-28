# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/hugs98/hugs98-2005.3.ebuild,v 1.2 2005/03/19 12:34:14 kosmikus Exp $

MY_PN="Omega"

MY_P="${MY_PN}${PV}"

DESCRIPTION="Omega"
SRC_URI="http://web.cecs.pdx.edu/~sheard/${MY_PN}/${MY_P}.zip"
HOMEPAGE="http://www.cs.pdx.edu/~sheard/Omega/"

SLOT="0"
KEYWORDS="~x86 ~amd64"
LICENSE="as-is" # TODO: fix license, this is something different
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.3"
DEPEND="$RDEPEND
	    app-arch/unzip"

S="${WORKDIR}/EugeneSumSch/distr/"
EXE="${PN}-lang"

src_unpack() {
	unpack ${A}
	cd ${S}

    #Have to change the name to avoid clashes with texlive-core
	sed -i "s|${PN}\\.exe|${EXE}|" Makefile || die Makefile not found
	sed -i "s|-package lang||g" Makefile || die Makefile not found
	sed -i "s|LangPrelude\\.prg|/usr/share/${P}/LangPrelude.prg|" Toplevel.hs
}
src_compile() {
	emake all || die "make failed"
}
src_install () {
	dobin ${EXE} || die "${EXE} executable not found"
	dodoc OmegaManual.ps
	insinto /usr/share/${P}
	doins LangPrelude.prg
}

pkg_postinst() {
    elog "To avoid collisions with app-text/texlive-core,"
    elog "the executable has been renamed from ${PN} to ${EXE}."
}
