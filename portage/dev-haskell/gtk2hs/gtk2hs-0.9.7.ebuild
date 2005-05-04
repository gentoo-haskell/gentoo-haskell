# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/gtk2hs/gtk2hs-0.9.7.ebuild,v 1.2 2005/03/23 16:15:53 seemant Exp $

inherit base check-reqs ghc-package

DESCRIPTION="GTK+-2.x bindings for Haskell"
HOMEPAGE="http://gtk2hs.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtk2hs/${P}.tar.gz"
LICENSE="LGPL-2 GPL-2"
SLOT="0"

KEYWORDS="~x86 ~ppc" #add ~sparc once we have ghc ~sparc

IUSE="doc gnome mozilla"

DEPEND=">=virtual/ghc-5.04
		>=x11-libs/gtk+-2
		gnome? ( >=gnome-base/libglade-2
				 >=x11-libs/gtksourceview-0.6
				 >=gnome-base/gconf-2 )
		mozilla? ( >=www-client/mozilla-1.4 )
		doc? ( >=dev-haskell/haddock-0.6 )"

pkg_setup() {
	# need this much memory (in MBytes) (does *not* check swap)
	CHECKREQS_MEMORY="400"

	check_reqs
}

src_compile() {
	econf \
		--libdir=$(ghc-libdir) \
		--with-hcflags="-O" \
		--without-pkgreg \
		`use_enable gnome gnome` \
		`use_enable gnome libglade` \
		`use_enable mozilla mozilla` \
		`use_enable doc docs` \
		|| die "Configure failed"

	# parallel build doesn't work, so specify -j1
	emake -j1 HSTOOLFLAGS="-H300m -M350m" || die "Make failed"
}

src_install() {

	make install \
		DESTDIR=${D} \
		htmldir="/usr/share/doc/${PF}/html" \
		haddockifacedir="/usr/share/doc/${PF}" \
		|| die "Make install failed"

	# arrange for the packages to be registered
	sed -i "s:\${pkglibdir}:$(ghc-libdir)/gtk2hs:" \
		${D}/$(ghc-libdir)/gtk2hs/*.pkg
	ghc-setup-pkg \
		"${D}/$(ghc-libdir)/gtk2hs/glib.pkg" \
		"${D}/$(ghc-libdir)/gtk2hs/gtk.pkg" \
		"${D}/$(ghc-libdir)/gtk2hs/mogul.pkg" \
		$(useq gnome && echo \
			"${D}/$(ghc-libdir)/gtk2hs/glade.pkg" \
			"${D}/$(ghc-libdir)/gtk2hs/gconf.pkg" \
			"${D}/$(ghc-libdir)/gtk2hs/sourceview.pkg") \
		$(useq mozilla && echo \
			"${D}/$(ghc-libdir)/gtk2hs/mozembed.pkg")
	ghc-install-pkg

	# build ghci .o files from .a files
	ghc-makeghcilib ${D}/$(ghc-libdir)/gtk2hs/libHSglib.a
	ghc-makeghcilib ${D}/$(ghc-libdir)/gtk2hs/libHSgtk.a
	ghc-makeghcilib ${D}/$(ghc-libdir)/gtk2hs/libHSmogul.a
	if use gnome; then
		ghc-makeghcilib ${D}/$(ghc-libdir)/gtk2hs/libHSglade.a
		ghc-makeghcilib ${D}/$(ghc-libdir)/gtk2hs/libHSgconf.a
		ghc-makeghcilib ${D}/$(ghc-libdir)/gtk2hs/libHSsourceview.a
	fi
	if use mozilla; then
		ghc-makeghcilib ${D}/$(ghc-libdir)/gtk2hs/libHSmozembed.a
	fi
}

