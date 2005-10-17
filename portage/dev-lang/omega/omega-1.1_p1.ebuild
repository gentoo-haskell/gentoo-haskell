# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/hugs98/hugs98-2005.3.ebuild,v 1.2 2005/03/19 12:34:14 kosmikus Exp $

IUSE="opengl"

MY_PV="1.11"
MY_PN="Omega"

DESCRIPTION="Omega"
SRC_URI="http://www.cs.pdx.edu/~sheard/Omega/${MY_PN}${MY_PV}.zip"
HOMEPAGE="http://www.cs.pdx.edu/~sheard/Omega/"

SLOT="0"
KEYWORDS="~x86"
LICENSE="as-is" # TODO: fix license, this is something different

DEPEND=">=virtual/ghc-6.4"

S="${WORKDIR}/${MY_PN}${MY_PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s|omega\\.exe|omega|" Makefile
	sed -i "s|LangPrelude\\.prg|/usr/share/${P}/LangPrelude.prg|" Toplevel.hs
}

src_compile() {
	emake || die "make failed"
}

src_install () {
	dobin omega
	dodoc OmegaManual.ps
	insinto /usr/share/${P}
	doins LangPrelude.prg
}

