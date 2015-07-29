# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/cvc3/cvc3-2.4.1.ebuild,v 1.5 2012/12/14 09:49:53 ulm Exp $

EAPI="5"

inherit autotools eutils elisp-common

DESCRIPTION="efficient open-source automatic theorem prover for Satisfiability Modulo Theories (SMT) problems"
HOMEPAGE="http://cvc4.cs.nyu.edu/web"
SRC_URI="http://cvc4.cs.nyu.edu/builds/src/${P}.tar.gz"

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

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc-5.patch
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
