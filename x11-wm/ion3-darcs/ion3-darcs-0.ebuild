# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit darcs

DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.modeemi.fi/tuomov/ion/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="xinerama xft"

EDARCS_REPOSITORY="http://iki.fi/tuomov/repos/ion-3"

RDEPEND="|| ( (
				x11-libs/libICE
				x11-libs/libXext
				x11-libs/libSM
				iontruetype? ( x11-libs/libXft )
				xinerama? ( x11-libs/libXinerama ) )
			virtual/x11 )
		app-misc/run-mailcap
		>=dev-lang/lua-5.1"
DEPEND="${RDEPEND}
		dev-libs/libextl-darcs
		dev-libs/libtu-darcs"

src_unpack() {
	darcs_src_unpack
	# predist.sh is required, but should not call darcs anymore (we want control about internet access)
	sed -i "s|^	 *do_darcs_export.*$||" predist.sh
	/bin/bash predist.sh -snapshot
}

src_compile() {
	cd ${S}/build/ac
	autoreconf -i
	econf \
		--sysconfdir=/etc/X11 \
		$(use_enable iontruetype xft) \
		$(use_enable xinerama) \
		$(use_disable hppa shared) \
		${myconf} || die

	cd ${S}
	emake DOCDIR="/usr/share/doc/${PF}" || die
}

src_install() {
	einstall \
		prefix=${D}/usr \
		ETCDIR=${D}/etc/X11/ion3 \
		SHAREDIR=${D}/usr/share/ion3 \
		MANDIR=${D}/usr/share/man \
		DOCDIR=${D}/usr/share/doc/${PF} \
		LOCALEDIR=${D}/usr/share/locale \
		LIBDIR=${D}/usr/lib \
		MODULEDIR=${D}/usr/lib/ion3/mod \
		LCDIR=${D}/usr/lib/ion3/lc \
		VARDIR=${D}/var/cache/ion3 \
		|| die

	prepalldocs

	echo -e "#!/bin/sh\n/usr/bin/ion3" > ${T}/ion3
	echo -e "#!/bin/sh\n/usr/bin/pwm3" > ${T}/pwm3
	exeinto /etc/X11/Sessions
	doexe ${T}/ion3 ${T}/pwm3

	insinto /usr/share/xsessions
	doins ${FILESDIR}/ion3.desktop ${FILESDIR}/pwm3.desktop
}
