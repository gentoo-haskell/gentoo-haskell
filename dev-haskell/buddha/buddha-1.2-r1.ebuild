# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/buddha/buddha-1.2.ebuild,v 1.6 2006/08/24 10:16:12 corsair Exp $

inherit base ghc-package multilib autotools eutils

DESCRIPTION="A declarative debugger for Haskell 98"
HOMEPAGE="http://www.cs.mu.oz.au/~bjpop/buddha/"
SRC_URI="http://www.cs.mu.oz.au/~bjpop/buddha/download/${P}.tar.gz
		mirror://gentoo/${P}-ghc66.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.4"
#will need dev-haskell/haskell-src for ghc-6.6

src_unpack() {
	base_src_unpack

	cd "${S}"
	epatch "${WORKDIR}/${P}-ghc66.patch"

	# Get rid of those 100's of pointless one-line 'wise' files:
	sed -i 's/advice//' "${S}/Makefile.am"
}

src_compile() {
	# Since we've patched the build system:
	eautoreconf

	econf --includedir=/usr/$(get_libdir)/buddha/include || die "Configure failed"

	# Makefile has no parallelism
	emake -j1 || die "Make failed"
}

src_install() {
	make DESTDIR=${D} install || die "Make install failed"

	#note that buddha's ghc packages do not need to be registered
}

pkg_postinst() {
	echo
	ewarn "WARNING: buddha-1.2 appears to generate code which is not"
	ewarn "fully compatible with ghc 6.4 or later.  We are working on this"
	ewarn "issue with the upstream developers.  Please do not report this"
	ewarn "as a bug, as we are already aware of the problem."
	echo
}
