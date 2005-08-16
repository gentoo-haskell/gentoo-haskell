# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit ghc-package

DESCRIPTION="Dynamically Loaded Haskell Plugins"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/hs-plugins/"
SRC_URI="ftp://ftp.cse.unsw.edu.au/pub/users/dons/${PN}/${P}.tar.gz
	doc? ( http://www.cse.unsw.edu.au/~dons/${PN}/${PN}.html.tar.gz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND=">=virtual/ghc
	>=dev-haskell/haskell-src-exts-0.2
	dev-haskell/cabal"

src_unpack() {
	unpack ${A}
	# for package management
	sed -i 's:\$(GHC_PKG) -u:\${GHC_PKGF} -u:' ${S}/Makefile

	cabalversion=$(ghc-bestcabalversion)

	sed -i "s:-package Cabal:-package ${cabalversion}:" \
		${S}/src/plugins/Makefile

	# Also specify an exact version of Cabal otherwise ghc-pkg defaults it to
	# the minimum version which is just wrong. Should be fixed in ghc-6.4.1
	sed -i "s/depends:\(.*\) Cabal/depends:\1 ${cabalversion}/" \
		${S}/src/plugins/plugins.conf.in.cpp
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

