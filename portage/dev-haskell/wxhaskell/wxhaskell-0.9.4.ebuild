# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/wxhaskell/wxhaskell-0.9.ebuild,v 1.2 2005/03/14 18:22:12 kosmikus Exp $

inherit flag-o-matic wxwidgets ghc-package

DESCRIPTION="a portable and native GUI library for Haskell"
HOMEPAGE="http://wxhaskell.sourceforge.net/"
SRC_URI="mirror://sourceforge/wxhaskell/${PN}-src-${PV}.zip"
LICENSE="wxWinLL-3"
SLOT="0"

KEYWORDS="~x86 ~ppc ~amd64"

IUSE="doc gtk2"

DEPEND="${DEPEND}
	>=virtual/ghc-6.2
	!>=virtual/ghc-6.4
	>=x11-libs/wxGTK-2.4.2-r2
	doc? ( >=dev-haskell/haddock-0.6-r2 )"

src_unpack() {
	unpack ${A}
	# adapt to Gentoo path convention
	sed -i 's:/doc/html:/share/doc/html:' ${S}/configure
	# fix Makefile to respect CXXFLAGS
	sed -i 's:^\(WXC-CXXFLAGS.*=\):\1\$(CXXFLAGS) :' ${S}/makefile
}

src_compile() {
	local wxconfig
	ghc-setup-pkg

	#wxhaskell supports gtk or gtk2, but not unicode yet:
	if ! use gtk2; then
		need-wxwidgets gtk
	else
		need-wxwidgets gtk2
	fi

	[ "${ARCH}" = "amd64" ] && append-flags -fPIC

	# non-standard configure, so econf is not an option
	wxconfig="${WX_CONFIG}"
	# --wx-config must appear first according to configure file comments 
	./configure \
		--wx-config=${wxconfig} \
		--prefix=${D}/usr \
		--with-opengl \
		--libdir=${D}/$(ghc-libdir) \
		--package-conf=${S}/$(ghc-localpkgconf) \
		|| die "./configure failed"

	emake -j1 || die "make failed"

	# create documentation
	if use doc; then
		emake -j1 doc || die "make doc failed"
	fi
}

src_install() {
	local f
	emake -j1 install || die "make install failed"
	for f in ${D}/$(ghc-libdir)/libwxc-*.so; do
		mv ${f} ${D}/usr/lib
	done

	if use doc; then
		dohtml -A haddock -r out/doc/*
		cp -r samples ${D}/usr/share/doc/${PF}
	fi

	ghc-install-pkg
}
