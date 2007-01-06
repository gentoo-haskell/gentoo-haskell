# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils java-pkg

DESCRIPTION="Helium (for learning Haskell)"
HOMEPAGE="http://www.cs.uu.nl/helium"
SRC_URI="http://www.cs.uu.nl/helium/distr/${P}-src.tar.gz
	java? ( http://www.cs.uu.nl/helium/distr/Hint-${PV}.jar )"

LICENSE="GPL-2"
SLOT="0"
# compilation breaks on amd64, suspect lvm doesn't work properly
KEYWORDS="-amd64 ~ppc -sparc ~x86"
IUSE="java readline"

DEPEND="virtual/ghc
		readline? ( sys-libs/readline )"
RDEPEND="dev-libs/gmp
		readline? ( sys-libs/readline )
		java? ( >=virtual/jre-1.4 )"

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
	# TODO: need to replace config.guess & config.sub to work on amd64
	./configure || die "lvm configure failed"
	popd
	cd helium || die "cannot cd to helium"
	econf --without-upx --without-ag || die "econf failed"
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
	if use java; then
		java-pkg_newjar "${DISTDIR}/Hint-${PV}.jar" Hint.jar \
			|| die "newjar jar failed"
	fi

	# create wrappers
	newbin "${FILESDIR}/helium-wrapper-${PV}" helium-wrapper

	dosym /usr/bin/helium-wrapper /usr/bin/texthint
	dosym /usr/bin/helium-wrapper /usr/bin/helium
	dosym /usr/bin/helium-wrapper /usr/bin/lvmrun
	use java && dosym /usr/bin/helium-wrapper /usr/bin/hint
	dosym /usr/bin/helium-wrapper /usr/bin/texthint-tc
	dosym /usr/bin/helium-wrapper /usr/bin/helium-tc
	dosym /usr/bin/helium-wrapper /usr/bin/lvmrun-tc
}

pkg_postinst() {
	elog "To use helium's simple library (without overloading) use"
	elog " \$ texthint"
	elog " \$ helium"
	elog " \$ lvmrun"
	elog ""
	elog "To use the libraries with overloading, use"
	elog " \$ texthint-tc"
	elog " \$ helium-tc"
	elog " \$ lvmrun-tc"	
	elog ""
	elog "The graphical interface Hint has a switch in its GUI,"
	elog "  Interpreter->Configure...->Enable overloading"
}

