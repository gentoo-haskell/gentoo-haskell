# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/gtk2hs/gtk2hs-0.9.10-r1.ebuild,v 1.1 2006/04/07 21:29:31 araujo Exp $

inherit base eutils ghc-package multilib toolchain-funcs versionator

DESCRIPTION="A GUI Library for Haskell based on Gtk+"
HOMEPAGE="http://haskell.org/gtk2hs/"
SRC_URI="mirror://sourceforge/gtk2hs/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="doc glade gnome opengl svg firefox seamonkey profile xulrunner"

RDEPEND=">=dev-lang/ghc-6.2
		dev-haskell/mtl
		>=x11-libs/gtk+-2
		glade? ( >=gnome-base/libglade-2 )
		gnome? ( >=gnome-base/libglade-2
				<x11-libs/gtksourceview-2.0
				>=gnome-base/gconf-2 )
		svg?   ( >=gnome-base/librsvg-2.16 )
		opengl? ( x11-libs/gtkglext )
		xulrunner? ( =net-libs/xulrunner-1.8* )
		!xulrunner? ( firefox? ( =www-client/mozilla-firefox-2* ) )
		!xulrunner? ( !firefox? ( seamonkey? ( =www-client/seamonkey-1* ) ) )"

DEPEND="${RDEPEND}
		doc? ( >=dev-haskell/haddock-0.8 )"

src_unpack() {
	unpack ${A}

	# Fix for recent glib that changes the type of the gtype typedef:
	sed -i -e 's/(CULong)/(CULong, CUInt)/' \
		"${S}/tools/hierarchyGen/Hierarchy.chs.template"

	# Fix for recent return type changes in librsvg-2.22.3:
	cd "${S}"
	epatch "${FILESDIR}/${PN}-0.9.12.1-librsvg-2.22.3.patch"

	# patch file missing, where is it?
	#Fix to work with new haddock-2.0.0.0:
	#if has_version '>=dev-haskell/haddock-2.0.0.0'; then
	#	cd "${S}"
	#	epatch "${FILESDIR}/${PN}-haddock-2.0.0.0.patch"
	#fi
}

src_compile() {
	econf \
		--enable-packager-mode \
		$(version_is_at_least "4.2" "$(gcc-version)" && \
			echo --disable-split-objs) \
		$(has_version '>=x11-libs/gtk+-2.8' && echo --enable-cairo) \
		$(use glade || use gnome && echo --enable-libglade) \
		$(use_enable gnome gconf) \
		$(use_enable gnome sourceview) \
		$(use_enable svg svg) \
		$(use_enable opengl opengl) \
		$(use_enable seamonkey seamonkey) \
		$(use_enable firefox firefox) \
		$(use_enable xulrunner xulrunner) \
		$(use_enable doc docs) \
		$(use_enable profile profiling) \
		|| die "Configure failed"

	# parallel build doesn't work, so specify -j1
	emake -j1 || die "Make failed"
}

src_install() {

	make install \
		DESTDIR="${D}" \
		htmldir="/usr/share/doc/${PF}/html" \
		haddockifacedir="/usr/share/doc/${PF}" \
		|| die "Make install failed"

	# for some reason it creates the doc dir even if it is configured
	# to not generate docs, so lets remove the empty dirs in that case
	# (and lets be cautious and only remove them if they're empty)
	if ! use doc; then
		rmdir "${D}/usr/share/doc/${PF}/html"
		rmdir "${D}/usr/share/doc/${PF}"
		rmdir "${D}/usr/share/doc"
		rmdir "${D}/usr/share"
	fi

	# arrange for the packages to be registered
	if ghc-cabal; then
		pkgext=package.conf
	else
		pkgext=pkg
	fi
	ghc-setup-pkg \
		"${D}/usr/$(get_libdir)/gtk2hs/glib.${pkgext}" \
		$(has_version '>=x11-libs/gtk+-2.8' && echo \
			"${D}/usr/$(get_libdir)/gtk2hs/cairo.${pkgext}") \
		"${D}/usr/$(get_libdir)/gtk2hs/gtk.${pkgext}" \
		"${D}/usr/$(get_libdir)/gtk2hs/soegtk.${pkgext}" \
		$(use glade || use gnome && echo \
			"${D}/usr/$(get_libdir)/gtk2hs/glade.${pkgext}") \
		$(use gnome && echo \
			"${D}/usr/$(get_libdir)/gtk2hs/gconf.${pkgext}" \
			"${D}/usr/$(get_libdir)/gtk2hs/sourceview.${pkgext}" ) \
		$(use svg && echo \
			"${D}/usr/$(get_libdir)/gtk2hs/svgcairo.${pkgext}") \
		$(use opengl && echo \
			"${D}/usr/$(get_libdir)/gtk2hs/gtkglext.${pkgext}") \
		$(use seamonkey || use firefox || use xulrunner && echo \
			"${D}/usr/$(get_libdir)/gtk2hs/mozembed.${pkgext}")
	ghc-install-pkg
}
