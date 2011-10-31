# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:	$

EAPI="3"

inherit base

MY_PN="Omega"

MY_P="${MY_PN}151"

DESCRIPTION="Omega"
SRC_URI="http://${MY_PN}.googlecode.com/files/${MY_P}.zip"
HOMEPAGE="http://www.cs.pdx.edu/~sheard/Omega/"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.3"
DEPEND="$RDEPEND
		app-arch/unzip"

S="${WORKDIR}/distr/"
EXE="${PN}-lang"

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

PATCHES=("${FILESDIR}/${P}-ghc-7.2.patch")
