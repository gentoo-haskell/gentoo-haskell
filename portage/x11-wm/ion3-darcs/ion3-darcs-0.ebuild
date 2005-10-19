# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:
# /var/darcsroot/gentoo-x86/x11-wm/ion3-darcs/ion3-darcs-99999999.ebuild,v 1.0 2005/10/16 12:06:54 ootput Exp $

inherit darcs

DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.modeemi.fi/tuomov/ion/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="xinerama"

EDARCS_REPOSITORY="http://iki.fi/tuomov/repos/ion-3"
EDARCS_GET_CMD="get --partial --verbose"

DEPEND="virtual/x11
	app-misc/run-mailcap
	>=dev-lang/lua-5.0.2"

# this functions checks wether the repository should be updated or downloaded
# from scratch
# $1 is reposititory $2 is directory from which to call darcs pull
download-darcs-repo() {
	EDARCS_REPOSITORY="$1" EDARCS_LOCALREPO="$2" darcs_fetch
}

src_unpack() {
	download-darcs-repo http://iki.fi/tuomov/repos/ion-3 ion-3 || die "ion-3 repo download failure"
	download-darcs-repo http://iki.fi/tuomov/repos/libtu-3 ion-3/libtu || die "libtu repo download failure"
	download-darcs-repo http://iki.fi/tuomov/repos/libextl-3 ion-3/libextl || die "libextl repo download failure"
	darcs_src_unpack
	cd ${S}
	# predist.sh is required, but should not call darcs anymore (we want control about internet access)
	sed -i "s|^  *do_darcs_export.*$||" predist.sh
	/bin/bash predist.sh -snapshot
}

src_compile() {

	autoreconf -i

	local myconf=""

	if has_version '>=x11-base/xfree-4.3.0'; then
		myconf="${myconf} --disable-xfree86-textprop-bug-workaround"
	fi

	use hppa && myconf="${myconf} --disable-shared"

	econf \
		--sysconfdir=/etc/X11 \
		`use_enable xinerama` \
		${myconf} || die

	make \
		DOCDIR=/usr/share/doc/${PF} || die

}

src_install() {

	make \
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
		install || die

	prepalldocs

	echo -e "#!/bin/sh\n/usr/bin/ion3" > ${T}/ion3
	echo -e "#!/bin/sh\n/usr/bin/pwm3" > ${T}/pwm3
	exeinto /etc/X11/Sessions
	doexe ${T}/ion3 ${T}/pwm3

	insinto /usr/share/xsessions
	doins ${FILESDIR}/ion3.desktop ${FILESDIR}/pwm3.desktop

}

