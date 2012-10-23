# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit base flag-o-matic

DESCRIPTION="Munster Curry Compiler"
HOMEPAGE="http://danae.uni-muenster.de/~lux/curry/"
SRC_URI="http://danae.uni-muenster.de/~lux/${PN}/download/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6"
RDEPEND="dev-libs/gmp
	sys-devel/gcc"

PATCHES=("${FILESDIR}/${P}-nostrip.patch"
	"${FILESDIR}/${P}-nonascii-chars.patch"
	"${FILESDIR}/${P}-fix-make-check.patch"
	"${FILESDIR}/${P}-fix-modern-ghc-configure.patch"
	"${FILESDIR}/${P}-fix-modern-ghc-replicateM.patch")

src_configure() {
	filter-flags "-O3 -finline-function"
	# The option -finline-function [which is included in -O3] breaks MCC.

	econf --enable-trampoline || die "econf failed"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -f ${FILESDIR}/${P}-fix-modern-ghc-imports.sed *.hs *.lhs */*.lhs
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README doc/*.pdf
}
