# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Bonn's Programming Language"
HOMEPAGE="http://www.iai.uni-bonn.de/~loeh/BPL"
SRC_URI="http://www.iai.uni-bonn.de/~loeh/BPL/${P}-source.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~amd64 ~ppc"

# also requires mtl for ghc-6.6, but the dependency language is not
# yet decided for this issue
DEPEND=">=dev-lang/ghc-6.4
	>=dev-haskell/frown-0.6
	>=dev-haskell/alex-2.0"
RDEPEND="dev-libs/gmp"

src_compile() {
	econf || die "econf failed"
	rm *.hs
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
