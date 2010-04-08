# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit base eutils ghc-package multilib toolchain-funcs versionator autotools darcs

DESCRIPTION="A GUI Library for Haskell based on Gtk+"
HOMEPAGE="http://haskell.org/gtk2hs/"
LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="doc glade gnome opengl svg profile xulrunner"

EDARCS_REPOSITORY="http://code.haskell.org/gtk2hs/"
EDARCS_GET_CMD="get --partial --verbose"
EDARCS_LOCALREPO="gtk2hs"

RDEPEND=">=dev-lang/ghc-6.2
		dev-haskell/mtl[doc?]
		dev-haskell/happy
		dev-haskell/alex
		x11-libs/gtk+:2
		glade? ( gnome-base/libglade )
		gnome? ( gnome-base/libglade
				>=x11-libs/gtksourceview-2.2
				gnome-base/gconf )
		svg?   ( gnome-base/librsvg )
		opengl? ( x11-libs/gtkglext )
		xulrunner? ( =net-libs/xulrunner-1.8* )"

DEPEND="${RDEPEND}
		doc? ( dev-haskell/haddock )
		dev-util/pkgconfig"

src_prepare() {
	cd "${S}"
	eautoreconf
}

src_configure() {
	econf \
		--enable-gtk \
		--enable-packager-mode \
		$(version_is_at_least "4.2" "$(gcc-version)" && \
			echo --disable-split-objs) \
		$(has_version '>=x11-libs/gtk+-2.8' && echo --enable-cairo --enable-gio) \
		$(use glade || use gnome && echo --enable-libglade) \
		$(use_enable gnome gconf) \
		$(use_enable gnome gtksourceview2) \
		$(use_enable svg svg) \
		$(use_enable opengl opengl) \
		--disable-firefox \
		$(use_enable xulrunner xulrunner) \
		$(use_enable doc docs) \
		$(use_enable profile profiling) \
		|| die "Configure failed"
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {

	make install \
		DESTDIR="${D}" \
		htmldir="/usr/share/doc/${PF}/html" \
		haddockifacedir="/usr/share/doc/${PF}" \
		|| die "Make install failed"

	# arrange for the packages to be registered
	ghc-setup-pkg \
		"${D}/usr/$(get_libdir)/gtk2hs/glib.package.conf" \
		$(has_version '>=x11-libs/gtk+-2.8' && echo \
			"${D}/usr/$(get_libdir)/gtk2hs/cairo.package.conf") \
		"${D}/usr/$(get_libdir)/gtk2hs/gtk.package.conf" \
		"${D}/usr/$(get_libdir)/gtk2hs/soegtk.package.conf" \
		$(use glade || use gnome && echo \
			"${D}/usr/$(get_libdir)/gtk2hs/glade.package.conf") \
		$(use gnome && echo \
			"${D}/usr/$(get_libdir)/gtk2hs/gconf.package.conf" \
			"${D}/usr/$(get_libdir)/gtk2hs/gtksourceview2.package.conf" ) \
		$(use svg && echo \
			"${D}/usr/$(get_libdir)/gtk2hs/svgcairo.package.conf") \
		$(use opengl && echo \
			"${D}/usr/$(get_libdir)/gtk2hs/gtkglext.package.conf") \
		$(use xulrunner && echo \
			"${D}/usr/$(get_libdir)/gtk2hs/mozembed.package.conf")
	ghc-install-pkg
}
