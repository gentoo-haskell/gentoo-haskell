# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/helium/helium-1.2-r1.ebuild,v 1.10 2009/04/17 20:07:20 caster Exp $

inherit eutils java-pkg-2

DESCRIPTION="Helium (for learning Haskell)"
HOMEPAGE="http://www.cs.uu.nl/helium"
SRC_URI="http://www.cs.uu.nl/helium/distr/${P}-src.tar.gz
	 http://www.cs.uu.nl/helium/distr/Hint.jar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -sparc ~ppc"
IUSE="readline"

DEPEND="<dev-lang/ghc-6.4
	!>=dev-lang/ghc-6.4
	readline? ( sys-libs/readline )"
RDEPEND=">=virtual/jre-1.4
	dev-libs/gmp
	readline? ( sys-libs/readline )"

src_unpack() {
	unpack ${P}-src.tar.gz

	# patch to use simple libraries by default
	epatch ${FILESDIR}/${P}-libraries.patch
	# patch for readline support if requested
	if use readline; then
		epatch ${FILESDIR}/${P}-readline.patch
	fi

	cp "${DISTDIR}/Hint.jar" "${WORKDIR}"
}

src_compile() {
	pushd lvm || die "cannot cd to lvm"
	pushd src || die "cannot cd to src"
	./configure || die "lvm configure failed"
	# for gcc 3.4 compatibility, patch file created by configure
	sed -i 's/#define strncpy(dest,src,size)  strcpy(dest,src)/#define HAS_SNPRINTF\n#define HAS_VSNPRINTF\n/'  config/s.h \
		|| die "patch to config/s.h didn't apply"
	popd
	popd
	pushd heliumNT || die "cannot cd to heliumNT"
	econf --without-upx || die "econf failed"
	pushd src || die "cannot cd to src"
	make depend || die "make depend failed"
	make || die "make failed" # emake doesn't work safely
}

src_install() {
	cd heliumNT/src || die "cannot cd to heliumNT/src"
	make prefix=${D}/usr \
		bindir=${D}/usr/lib/helium/bin \
		libdir=${D}/usr/lib/helium/lib \
		tclibdir=${D}/usr/lib/helium/tclib \
		demodir=${D}/usr/lib/helium/demo \
		install || die "make failed"
	# install hint
	java-pkg_dojar "${WORKDIR}/Hint.jar"
	# create wrappers
	dobin ${FILESDIR}/helium-wrapper
	dosym /usr/bin/helium-wrapper /usr/bin/helium
	dosym /usr/bin/helium-wrapper /usr/bin/lvmrun
	dosym /usr/bin/helium-wrapper /usr/bin/texthint
	dosym /usr/bin/helium-wrapper /usr/bin/hint
	dosym /usr/bin/helium-wrapper /usr/bin/helium-tc
	dosym /usr/bin/helium-wrapper /usr/bin/lvmrun-tc
	dosym /usr/bin/helium-wrapper /usr/bin/texthint-tc
	dosym /usr/bin/helium-wrapper /usr/bin/hint-tc
}
