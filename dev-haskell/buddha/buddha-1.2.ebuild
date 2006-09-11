# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/buddha/buddha-1.2.ebuild,v 1.6 2006/08/24 10:16:12 corsair Exp $

inherit base ghc-package autotools

DESCRIPTION="A declarative debugger for Haskell 98"
HOMEPAGE="http://www.cs.mu.oz.au/~bjpop/buddha/"
SRC_URI="http://www.cs.mu.oz.au/~bjpop/buddha/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=virtual/ghc-6.0"

DEPEND="${RDEPEND}"

src_unpack() {
	base_src_unpack

	cd "${S}"
	epatch "${FILESDIR}/${P}-ghc66.patch"
}

src_compile() {
	#lets put the interface files in a sensible place shall we?
	sed -i 's:AM_IFACEDIR = $(pkgdatadir)/ifaces:AM_IFACEDIR = $(pkglibdir)/ifaces:' \
		${S}/data/Makefile.in ${S}/scripts/Makefile.in \
		${S}/libbuddha/Makefile.in ${S}/prelude/Buddha/Makefile.in

	# Since we've patched the build system:
	eautoreconf

	econf --libdir=$(ghc-libdir) || die "Configure failed"

	# Makefile has no parallelism
	emake -j1 || die "Make failed"
}

src_install() {

	make DESTDIR=${D} install || die "Make install failed"
	#note that buddha's ghc packages do not need to be registered

	#get rid of those 100's of pointless one-line 'wise' files:
	rm "${D}/usr/share/buddha/wise"*
}
