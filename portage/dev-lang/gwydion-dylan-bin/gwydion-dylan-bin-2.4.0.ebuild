# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="The Dylan Programming Language Compiler"
HOMEPAGE="http://www.gwydiondylan.org/"
SRC_URI="x86? ( http://dev.gentoo.org/~araujo/stuff/bin/${P}-x86.tbz2 )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="nostrip"
LOC="/opt/gwydion-dylan"

DEPEND=""
RDEPEND=">=dev-libs/boehm-gc-6.4"

PROVIDE="virtual/gwydion-dylan"

S="${WORKDIR}"

src_compile() {
  	mkdir -p ./${LOC}
	mv usr/* ./${LOC}
}

src_install() {
	cp -pr * ${D}
	insinto /etc/env.d
	doins ${FILESDIR}/20gwydion-dylan
}
