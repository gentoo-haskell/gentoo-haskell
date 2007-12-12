# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hsshellscript/hsshellscript-2.6.3.ebuild,v 1.1 2006/08/15 00:28:58 araujo Exp $

inherit base eutils multilib ghc-package

DESCRIPTION="A Haskell library for UNIX shell scripting tasks"
HOMEPAGE="http://www.volker-wysk.de/hsshellscript/"
SRC_URI="http://www.volker-wysk.de/hsshellscript/dist/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE="doc"

DEPEND=">=dev-lang/ghc-6.4
	>=dev-libs/glib-2.0
	doc? ( >=dev-haskell/haddock-0.6 )"
RDEPEND=""

pkg_setup() {
	HSLIB="/usr/$(get_libdir)/${P}/ghc-$(ghc-version)/"
}

src_unpack() {
	base_src_unpack
	# Don't register the package
	sed -i "/ghc-pkg/d" "${S}/Makefile"
	# Fix hsshellscript.pkg library path
	sed -i "s:@DEST_LIB:${HSLIB}:" "${S}/lib/hsshellscript.pkg"
	sed -i "s:@DEST_IMPORTS:${HSLIB}/imports:" "${S}/lib/hsshellscript.pkg"
}

src_compile() {
	make lib lib_p build/hsshellscript.pkg || die "emake failed"
}

src_test() {
	make tests
}

src_install() {
	ghc-setup-pkg "${S}/build/hsshellscript.pkg"
	make install \
		DESTDIR="${D}" \
		DEST_LIB="${HSLIB}" \
		DEST_IMPORTS="${HSLIB}/imports" install_lib \
		|| die "make failed"

	if use doc; then
		make DEST_DOC="${D}/usr/share/doc/${PF}" install_doc
	fi

	ghc-makeghcilib "${D}/${HSLIB}/libhsshellscript.a"
	ghc-install-pkg
	fperms 0644 "${HSLIB}/imports/hsshellscript.h"
}
