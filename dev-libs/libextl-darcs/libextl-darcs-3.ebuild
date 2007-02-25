# Copyright 2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit darcs

EDARCS_REPOSITORY="http://iki.fi/tuomov/repos/libextl-3"
DESCRIPTION="Lua interfacing library for Ion3"
HOMEPAGE="http://www.modeemi.fi/tuomov/ion/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
DEPEND=">=dev-lang/lua-5.1
		dev-libs/libtu-darcs"

IUSE=""

src_compile() {
	emake CFLAGS="${CFLAGS}" LUA="/usr/bin/lua" || die
}

src_install() {
	einstall PREFIX="${D}/usr" || die
}
