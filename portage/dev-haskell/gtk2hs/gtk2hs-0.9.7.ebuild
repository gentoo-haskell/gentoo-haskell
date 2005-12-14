# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/gtk2hs/gtk2hs-0.9.7.ebuild,v 1.2 2005/03/23 16:15:53 seemant Exp $

inherit base check-reqs ghc-package

DESCRIPTION="GTK+-2.x bindings for Haskell"
HOMEPAGE="http://haskell.org/gtk2hs/"
SRC_URI="mirror://sourceforge/gtk2hs/${P}.tar.gz"
LICENSE="LGPL-2 GPL-2"
SLOT="0"

KEYWORDS="~x86 ~ppc -amd64 ~sparc"

IUSE="doc gnome mozilla"

DEPEND=">=virtual/ghc-5.04
		>=x11-libs/gtk+-2
		gnome? ( >=gnome-base/libglade-2
				 >=x11-libs/gtksourceview-0.6
				 >=gnome-base/gconf-2 )
		mozilla? ( >=www-client/mozilla-1.4 )
		doc? ( =dev-haskell/haddock-0.6* )"

pkg_setup() {
	# need this much memory (in MBytes) (does *not* check swap)
	CHECKREQS_MEMORY="400"

	check_reqs
}

src_unpack() {
	base_src_unpack

	# patch for GHC 6.4 compatability
	epatch ${FILESDIR}/gtk2hs-0.9.7-ghc64.patch.gz
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
	emake -j1 HSTOOLFLAGS="-H380m -M380m" || die "Make failed"
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
		"${D}/$(ghc-libdir)/gtk2hs/glib.${pkgext}" \
		"${D}/$(ghc-libdir)/gtk2hs/gtk.${pkgext}" \
		"${D}/$(ghc-libdir)/gtk2hs/mogul.${pkgext}" \
		$(useq gnome && echo \
			"${D}/$(ghc-libdir)/gtk2hs/glade.${pkgext}" \
			"${D}/$(ghc-libdir)/gtk2hs/gconf.${pkgext}" \
			"${D}/$(ghc-libdir)/gtk2hs/sourceview.${pkgext}") \
		$(useq mozilla && echo \
			"${D}/$(ghc-libdir)/gtk2hs/mozembed.${pkgext}")
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

