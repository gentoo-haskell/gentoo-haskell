# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/helium/helium-1.2-r1.ebuild,v 1.5 2005/07/24 22:41:49 dcoutts Exp $

inherit eutils java-pkg

DESCRIPTION="Helium (for learning Haskell)"
HOMEPAGE="http://www.cs.uu.nl/helium"
SRC_URI="http://www.cs.uu.nl/helium/distr/${P}-src.tar.gz
	 http://www.cs.uu.nl/helium/distr/Hint-${PV}.jar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -sparc ~ppc"
IUSE="readline"

DEPEND="virtual/libc
	virtual/ghc
	readline? ( sys-libs/readline )"
RDEPEND="virtual/libc
	virtual/jdk
	dev-libs/gmp
	readline? ( sys-libs/readline )"

src_unpack() {
	unpack ${P}-src.tar.gz

	# patch to install type class libraries too
	epatch ${FILESDIR}/${P}-libraries.patch

	# patch for readline support if requested
	if use readline; then
		epatch "${FILESDIR}/${P}-readline.patch"
	fi
}

src_compile() {
	pushd lvm/src || die "cannot cd to lvm/src"
	./configure || die "lvm configure failed"
	popd
	cd helium || die "cannot cd to helium"
	econf --without-upx || die "econf failed"
	cd src || die "cannot cd to src"
	make depend || die "make depend failed"

	EXTRA_HC_OPTS="-O"
	if use readline; then
		EXTRA_HC_OPTS="${EXTRA_HC_OPTS} -package readline"
	fi
	make EXTRA_HC_OPTS="${EXTRA_HC_OPTS}" \
		|| die "make failed" # emake doesn't work safely
}

src_install() {
	cd helium/src || die "cannot cd to helium/src"
	make prefix="${D}/usr" \
		bindir="${D}/usr/lib/helium/bin" \
		libdir="${D}/usr/lib/helium/lib/simple" \
		tclibdir="${D}/usr/lib/helium/lib" \
		demodir="${D}/usr/lib/helium/demo" \
		install || die "make failed"

	# install hint
	java-pkg_newjar "${DISTDIR}/Hint-${PV}.jar" Hint.jar \
		|| die "newjar jar failed"

	# create wrappers
	newbin "${FILESDIR}/helium-wrapper-${PV}" helium-wrapper

	dosym /usr/bin/helium-wrapper /usr/bin/texthint
	dosym /usr/bin/helium-wrapper /usr/bin/helium
	dosym /usr/bin/helium-wrapper /usr/bin/lvmrun
	dosym /usr/bin/helium-wrapper /usr/bin/hint
	dosym /usr/bin/helium-wrapper /usr/bin/texthint-tc
	dosym /usr/bin/helium-wrapper /usr/bin/helium-tc
	dosym /usr/bin/helium-wrapper /usr/bin/lvmrun-tc
}

pkg_postinst() {
	einfo "To use helium's simple library (without overloading) use"
	einfo " \$ texthint"
	einfo " \$ helium"
	einfo " \$ lvmrun"
	einfo ""
	einfo "To use the libraries with overloading, use"
	einfo " \$ texthint-tc"
	einfo " \$ helium-tc"
	einfo " \$ lvmrun-tc"
	einfo ""
	einfo "The graphical interface Hint has a switch in its GUI,"
	einfo "  Interpreter->Configure...->Enable overloading"
}

