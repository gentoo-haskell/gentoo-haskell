# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit base

DESCRIPTION="jhc is a haskell compiler"
HOMEPAGE="http://repetae.net/computer/jhc/"
SRC_URI="http://repetae.net/computer/jhc/drop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4
		>=dev-haskell/drift-2.2.3
		dev-haskell/binary
		dev-haskell/fgl
		dev-haskell/quickcheck
		dev-haskell/mtl
		dev-haskell/zlib"
RDEPEND=""

src_compile() {
	econf || die "configure failed"
	emake -j1 GHCDEBUGOPTS="" || die "make failed"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
}
