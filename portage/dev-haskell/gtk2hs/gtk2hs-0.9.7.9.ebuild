# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/gtk2hs/gtk2hs-0.9.7.ebuild,v 1.2 2005/03/23 16:15:53 seemant Exp $

inherit base ghc-package

DESCRIPTION="GTK+-2.x bindings for Haskell"
HOMEPAGE="http://haskell.org/gtk2hs/"
#SRC_URI="mirror://sourceforge/gtk2hs/${P}.tar.gz"
SRC_URI="http://haskell.org/~duncan/gtk2hs/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"

KEYWORDS="~x86 ~ppc ~sparc"

IUSE="doc gnome mozilla"

DEPEND=">=virtual/ghc-5.04
		>=x11-libs/gtk+-2
		gnome? ( >=gnome-base/libglade-2
				 >=x11-libs/gtksourceview-0.6
				 >=gnome-base/gconf-2 )
		mozilla? ( >=www-client/mozilla-1.4 )
		doc? ( >=dev-haskell/haddock-0.6 )"

src_compile() {
	econf \
		--enable-packager-mode \
		--with-hcflags=-H50m \
		`use_enable gnome libglade` \
		`use_enable gnome gconf` \
		`use_enable gnome sourceview` \
		`use_enable mozilla mozilla` \
		`use_enable doc docs` \
		|| die "Configure failed"

	# parallel build doesn't work, so specify -j1
	emake -j1 || die "Make failed"
}

src_install() {

	make install \
		DESTDIR=${D} \
		htmldir="/usr/share/doc/${PF}/html" \
		haddockifacedir="/usr/share/doc/${PF}" \
		|| die "Make install failed"

	# for some reason it creates the doc dir even if it is configured
	# to not generate docs, so lets remove the empty dirs in that case
	# (and lets be cautious and only remove them if they're empty)
	if ! use doc; then
		rmdir ${D}/usr/share/doc/${PF}/html
		rmdir ${D}/usr/share/doc/${PF}
		rmdir ${D}/usr/share/doc
		rmdir ${D}/usr/share
	fi

	# arrange for the packages to be registered
	if ghc-cabal; then
		pkgext=cabal
	else
		pkgext=pkg
	fi
	ghc-setup-pkg \
		"${D}/usr/lib/gtk2hs/glib.${pkgext}" \
		"${D}/usr/lib/gtk2hs/gtk.${pkgext}" \
		"${D}/usr/lib/gtk2hs/mogul.${pkgext}" \
		$(useq gnome && echo \
			"${D}/usr/lib/gtk2hs/glade.${pkgext}" \
			"${D}/usr/lib/gtk2hs/gconf.${pkgext}" \
			"${D}/usr/lib/gtk2hs/sourceview.${pkgext}") \
		$(useq mozilla && echo \
			"${D}/usr/lib/gtk2hs/mozembed.${pkgext}")
	ghc-install-pkg

	# build ghci .o files from .a files
	ghc-makeghcilib ${D}/usr/lib/gtk2hs/libHSglib.a
	ghc-makeghcilib ${D}/usr/lib/gtk2hs/libHSgtk.a
	ghc-makeghcilib ${D}/usr/lib/gtk2hs/libHSmogul.a
	if use gnome; then
		ghc-makeghcilib ${D}/usr/lib/gtk2hs/libHSglade.a
		ghc-makeghcilib ${D}/usr/lib/gtk2hs/libHSgconf.a
		ghc-makeghcilib ${D}/usr/lib/gtk2hs/libHSsourceview.a
	fi
	if use mozilla; then
		ghc-makeghcilib ${D}/usr/lib/gtk2hs/libHSmozembed.a
	fi
}

