# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils elisp-common

DESCRIPTION="automatic theorem prover for Satisfiability Modulo Theories (SMT) problems"
HOMEPAGE="http://cvc4.cs.nyu.edu/web"
SRC_URI="http://cvc4.cs.nyu.edu/builds/src/${P}.tar.gz"

LICENSE="BSD MIT HPND"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+cln compat glpk"

RESTRICT=test # many tests SIGSEGV at least on gcc-5.2.0

RDEPEND=">=dev-libs/antlr-c-3.2
	dev-libs/boost:=
	>=dev-libs/gmp-4.2:=
	cln? ( sci-libs/cln )
	compat? ( !sci-mathematics/cvc3 )
	glpk? ( sci-mathematics/glpk )
"
DEPEND="${RDEPEND}
	app-shells/bash
	sys-devel/gcc[cxx]
"

PATCHES=(
	"${FILESDIR}"/${P}-gcc-5.patch
	"${FILESDIR}"/${P}-gcc-6.patch
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--disable-assertions \
		$(use_with compat) \
		--with-$(usex cln cln gmp) \
		$(use_enable cln gpl) \
		$(use_with glpk)
}
