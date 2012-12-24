# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/hugs98/hugs98-2005.3-r2.ebuild,v 1.2 2006/02/16 11:52:55 dcoutts Exp $

inherit base flag-o-matic eutils versionator multilib

IUSE="X opengl openal doc"

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
DESCRIPTION="The Hugs98 Haskell interpreter"
SRC_URI="http://cvs.haskell.org/Hugs/downloads/${MY_PV}/${MY_P}.tar.gz
	http://cvs.haskell.org/Hugs/downloads/${MY_PV}/${MY_P}-patch.gz"
HOMEPAGE="http://www.haskell.org/hugs/"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
LICENSE="BSD"

RDEPEND="
	X? ( || ( x11-libs/libX11 virtual/x11 ) )
	opengl? ( virtual/opengl media-libs/freeglut )
	openal? ( media-libs/openal )"
DEPEND="${RDEPEND}
	opengl? ( app-admin/eselect-opengl )
	~app-text/docbook-sgml-dtd-4.2"

# the testsuite is not included in the tarball
RESTRICT="test"

src_unpack() {
	base_src_unpack
	cd "${S}"
	epatch "${WORKDIR}"/${MY_P}-patch
	epatch "${FILESDIR}"/${P}-openal.patch
	epatch "${FILESDIR}"/${P}-find.patch
	epatch "${FILESDIR}"/${P}-conditional-doc.patch

	if ! use X; then
		sed -i -e 's/X11//' -e 's/HGL//' "${S}/Makefile" \
			"${S}/libraries/tools/convert_libraries" \
			"${S}/libraries/tools/test_libraries"
		rm -r "${S}/fptools/libraries/X11" "${S}/fptools/libraries/HGL"
	fi

	if ! use opengl; then
		sed -i -e 's/OpenGL//' -e 's/GLUT//' "${S}/Makefile" \
			"${S}/libraries/tools/convert_libraries" \
			"${S}/libraries/tools/test_libraries"
		rm -r "${S}/fptools/libraries/OpenGL" "${S}/fptools/libraries/GLUT"
	fi

	if ! use openal; then
		sed -i 's/OpenAL//' "${S}/Makefile" \
			"${S}/libraries/tools/convert_libraries" \
			"${S}/libraries/tools/test_libraries"
		rm -r "${S}/fptools/libraries/OpenAL"
	fi
}

src_compile() {
	local myconf

	# Strip -O? from CFLAGS because of bugs
	# in the garbage collection of gcc on ppc.
	# See bug #73611
	[ "${ARCH}" = "ppc" ] && filter-flags "-O?"

	if use opengl; then
		myconf="--enable-opengl"
		# the nvidia drivers *seem* not to work together with pthreads
		if ! /usr/bin/eselect opengl show | grep -q nvidia; then
			myconf="$myconf --with-pthreads"
		fi
	fi

	econf \
		--build=${CHOST} \
		--enable-ffi \
		--enable-profiling \
		${myconf} || die "econf failed"
	emake || die "make failed"

	if use doc; then
		emake doc || die "make doc failed"
	fi
}

src_install () {
	emake install DESTDIR="${D}" || die "make install failed"

	if use doc; then
		emake install_doc DESTDIR="${D}" || die "make install_doc failed"
	fi

	#somewhat clean-up installation of few docs
	cd "${S}"
	dodoc Credits License Readme
	cd "${D}/usr/$(get_libdir)/hugs"
	rm Credits License Readme
	mv demos/ docs/ "${D}/usr/share/doc/${PF}"
}
