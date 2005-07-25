# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/hugs98/hugs98-2005.3.ebuild,v 1.2 2005/03/19 12:34:14 kosmikus Exp $

inherit base flag-o-matic eutils versionator

IUSE="opengl"

# version numbering of Hugs is rather strange
# we have to transform 2003.11 -> Nov2003
HUGS_MONTH_NR=$(get_version_component_range 2)

transform_month() {
	case "$1" in
		1) echo "Jan";;
		2) echo "Feb";;
		3) echo "Mar";;
		4) echo "Apr";;
		5) echo "May";;
		6) echo "Jun";;
		7) echo "Jul";;
		8) echo "Aug";;
		9) echo "Sep";;
		10) echo "Oct";;
		11) echo "Nov";;
		12) echo "Dec";;
		*) echo "";;
	esac
}

HUGS_MONTH=$(transform_month ${HUGS_MONTH_NR})
MY_PV="${HUGS_MONTH}$(get_major_version )"
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="The HUGS98 Haskell interpreter"
SRC_URI="http://cvs.haskell.org/Hugs/downloads/${MY_PV}/${MY_P}.tar.gz
		 http://cvs.haskell.org/Hugs/downloads/${MY_PV}/${MY_P}-patch.gz"
HOMEPAGE="http://www.haskell.org/hugs/"

SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
LICENSE="as-is"

DEPEND="virtual/libc
	opengl? ( virtual/opengl virtual/glu virtual/glut )
	~app-text/docbook-sgml-dtd-4.2"

src_unpack() {
	base_src_unpack
	cd ${S}
	epatch ${WORKDIR}/${MY_P}-patch
	cd ${S}/src
}

src_compile() {
	local myconf

	# Strip -O? from CFLAGS because of bugs
	# in the garbage collection of gcc on ppc.
	# See bug #73611
	[ "${ARCH}" = "ppc" ] && filter-flags "-O?"

	if use opengl; then
		myconf="--enable-hopengl"
		# the nvidia drivers *seem* not to work together
		# with pthreads
		[ ! -f /etc/env.d/09opengl ] \
			|| [ -z "`grep opengl/nvidia/lib /etc/env.d/09opengl`" ] \
			&& myconf="$myconf --with-pthreads" \
			|| myconf="--with-pthreads"
	fi

	# cd ${S}/src/unix || die "source directory not found"
	econf \
		--build=${CHOST} \
		--enable-ffi \
		--enable-profiling \
		${myconf} || die "econf failed"
	# cd ..
	emake || die "make failed"
}

src_install () {
	make install DESTDIR="${D}" || die "make install failed"

	#somewhat clean-up installation of few docs
	cd ${S}
	dodoc Credits License Readme
	cd ${D}/usr/lib/hugs
	rm Credits License Readme
	mv demos/ docs/ ${D}/usr/share/doc/${PF}
}
