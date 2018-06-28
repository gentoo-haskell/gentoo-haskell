# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="automatic theorem prover for Satisfiability Modulo Theories (SMT) problems"
HOMEPAGE="https://cvc4.cs.stanford.edu/"
SRC_URI="https://cvc4.cs.stanford.edu/downloads/builds/src/${P}.tar.gz"

LICENSE="BSD MIT HPND"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+cln compat glpk"

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

src_configure() {
	econf \
		--disable-assertions \
		$(use_with compat) \
		--with-$(usex cln cln gmp) \
		$(use_enable cln gpl) \
		$(use_with glpk)
}
