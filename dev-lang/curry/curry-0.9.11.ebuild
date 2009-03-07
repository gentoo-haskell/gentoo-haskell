# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit flag-o-matic

DESCRIPTION="Münster Curry Compiler"
HOMEPAGE="http://danae.uni-muenster.de/~lux/curry/"
SRC_URI="http://danae.uni-muenster.de/~lux/${PN}/download/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6"
RDEPEND="dev-libs/gmp
	sys-devel/gcc"

src_prepare() {
	epatch "${FILESDIR}/${P}-nostrip.patch"
}
src_configure() {
	filter-flags "-O3 -finline-function"
	# The option -finline-function [which is included in -O3] breaks MCC.

	econf --enable-trampoline || die "econf failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc README doc/*.pdf
}
