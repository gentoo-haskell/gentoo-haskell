# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit base ghc-package

IUSE="doc"

DESCRIPTION="Dynamically Loaded Haskell Plugins"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/hs-plugins/"
SRC_URI="ftp://ftp.cse.unsw.edu.au/pub/users/dons/${PN}/${P}.tar.gz
doc? ( http://www.cse.unsw.edu.au/~dons/${PN}/${PN}.html.tar.gz )"

SLOT="0"
KEYWORDS="~x86"
LICENSE="as-is"

DEPEND=">=virtual/ghc
	>=dev-haskell/haskell-src-exts-0.2"

RDEPEND=""

src_unpack() {
	unpack ${A}
	# for package management
	sed -i 's:\$(GHC_PKG) -u:\${GHC_PKGF} -u:' ${S}/Makefile
}

src_compile() {
	econf
	# for package management
	echo 'GHC_PKGF = ${GHC_PKG} --force -f '"${S}/$(ghc-localpkgconf)" >> config.mk
	emake -j1
}

src_install() {
	emake PREFIX="${D}/usr" install
	ghc-setup-pkg
	emake PREFIX="${D}/usr" register # then we don't need --force in ghc-pkg
	ghc-install-pkg

	dodoc AUTHORS README TODO VERSION

	if use doc; then
		dohtml ${WORKDIR}/${PN}/*
	fi
}

