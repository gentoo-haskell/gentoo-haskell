# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/helium/helium-1.6.ebuild,v 1.2 2007/10/31 13:22:01 dcoutts Exp $

inherit eutils

DESCRIPTION="Helium (for learning Haskell)"
HOMEPAGE="http://www.cs.uu.nl/helium"
SRC_URI="http://www.cs.uu.nl/helium/distr/${P}-src.tar.gz
	mirror://gentoo/${P}-ghc.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
# compilation breaks on amd64, suspect lvm doesn't work properly
KEYWORDS="-amd64 ~ppc -sparc ~x86"
IUSE="readline"

DEPEND=">=dev-lang/ghc-6.4.2
	readline? ( sys-libs/readline )"
RDEPEND="dev-libs/gmp
	readline? ( sys-libs/readline )"

src_unpack() {
	unpack ${A}
	epatch "${P}-ghc.patch"
}

src_compile() {
	# helium consists of two components that have to be set up separately,
	# lvm and the main compiler. both build systems are slightly strange.
	# lvm uses a completely non-standard build system:
	# the ./configure of lvm is not the usual autotools configure

	cd "${S}/lvm/src" && ./configure || die "lvm configure failed"
	echo "STRIP=echo" >> config/makefile || die "lvm postconfigure failed"
	myconf="$(use_enable readline) --without-strip --without-upx --without-ag"
	cd "${S}/helium" && econf --prefix="/usr/lib" ${myconf} || die "econf failed"
	cd "${S}/helium/src" && make depend || die "make depend failed"

	emake -j1 || die "make failed"
}

src_install() {
	cd helium/src || die "cannot cd to helium/src"
	make install bindir="/usr/lib/helium/bin" DESTDIR="${D}" || die "make install failed"

	# create wrappers
	newbin "${FILESDIR}/helium-wrapper-${PV}" helium-wrapper

	dosym /usr/bin/helium-wrapper /usr/bin/texthint
	dosym /usr/bin/helium-wrapper /usr/bin/helium
	dosym /usr/bin/helium-wrapper /usr/bin/lvmrun
}
