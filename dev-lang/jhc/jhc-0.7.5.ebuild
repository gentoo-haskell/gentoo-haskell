# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit base

DESCRIPTION="jhc is a haskell compiler"
HOMEPAGE="http://repetae.net/john/computer/jhc/"
SRC_URI="http://repetae.net/computer/jhc/drop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10
		dev-haskell/binary
		>=dev-haskell/drift-2.1.1
		dev-haskell/fgl
		dev-haskell/happy
		dev-haskell/mtl
		dev-haskell/readline
		dev-haskell/regex-compat
		dev-haskell/utf8-string
		dev-haskell/zlib"
RDEPEND=""

PATCHES=("${FILESDIR}/jhc-0.7.5-left-out-jhc-inst.num.patch")

src_configure() {
	econf || die "econf failed"
}

src_compile() {
	emake jhc || die "'emake jhc' failed"
	emake libs || die "'emake libs' failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
}
