# Copyright 2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit darcs

EDARCS_REPOSITORY="http://iki.fi/tuomov/repos/libtu-3"
DESCRIPTION="Utility library for Ion3"
HOMEPAGE="http://www.modeemi.fi/tuomov/ion/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lang/lua"
IUSE=""

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	einstall PREFIX="${D}/usr/" || die
}
