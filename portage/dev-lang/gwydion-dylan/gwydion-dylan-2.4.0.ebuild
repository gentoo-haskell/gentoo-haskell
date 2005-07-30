# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="The Dylan Programming Language Compiler"
HOMEPAGE="http://www.gwydiondylan.org/"
SRC_URI="http://www.gwydiondylan.org/downloads/src/tar/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="gtk"

DEPEND="virtual/gwydion-dylan
		>=dev-libs/boehm-gc-6.4
		gtk? ( =x11-libs/gtk+-1.2* )"
RDEPEND=""

PROVIDE="virtual/gwydion-dylan"

src_compile() {
	./configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		$(use_with gtk) \
		|| die "./configure failed"
	
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install \
		|| die "make failed"
}
