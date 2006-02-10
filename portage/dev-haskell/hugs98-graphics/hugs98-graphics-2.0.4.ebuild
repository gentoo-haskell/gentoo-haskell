# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hugs98-graphics/hugs98-graphics-2.0.4.ebuild,v 1.5 2005/05/04 17:46:04 dholm Exp $

DESCRIPTION="Haskell Graphics Library for X"
HOMEPAGE="http://cvs.haskell.org/Hugs/pages/downloading.htm"
SRC_URI="http://cvs.haskell.org/Hugs/downloads/graphics-${PV}.src.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="virtual/libc
	dev-lang/hugs98
	x11-libs/libX11
	|| ( || ( x11-base/xorg-server
	     		x11-base/xdirectfb
		 		x11-base/kdrive
				>=x11-base/xorg-x11-6.8
		 		)
	     		virtual/x11 )"
S=${WORKDIR}/graphics-${PV}
# where Hugs is installed
HUGSDIR="/usr/lib/hugs"
# where Hugs libraries get installed
HUGSLIBDIR="${D}${HUGSDIR}/lib"

src_compile() {
	# the package does not use configure
	make -C lib/x11 hugs_install=${HUGSDIR}
}

src_install() {
	dodoc Install License Readme Version Version-2.0.4
	# don't gzip dvi file
	install -m0644 doc/Graphics.dvi "${D}usr/share/doc/${PF}"
	# don't gzip demo file
	install -m0644 demos/HelloWorld.hs "${D}usr/share/doc/${PF}"

	mkdir -p ${HUGSLIBDIR}
	cp -R lib/x11/* ${HUGSLIBDIR}
}
