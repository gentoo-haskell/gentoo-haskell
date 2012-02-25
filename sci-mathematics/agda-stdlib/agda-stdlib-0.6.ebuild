# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Agda standard library"
HOMEPAGE="http://wiki.portal.chalmers.se/agda/"
SRC_URI="http://www.cse.chalmers.se/~nad/software/lib-${PV}.tar.gz -> ${P}.tar.gz"

inherit elisp-common

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=sci-mathematics/agda-executable-2.3.0"
RDEPEND="=sci-mathematics/agda-2.3.0"

SITEFILE="50${PN}-gentoo.el"

S="${WORKDIR}/lib-${PV}"

src_compile() {
	agda +RTS -K1G -RTS -i ${S} -i ${S}/src ${S}/Everything.agda
	agda --html -i ${S} -i ${S}/src ${S}/README.agda
}

src_test() {
	agda -i ${S} -i ${S}/src README.agda
}

src_install() {
	insinto usr/share/agda-stdlib
	doins -r src/*
	dodoc -r html/*
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}
