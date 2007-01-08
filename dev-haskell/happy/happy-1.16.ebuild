# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/happy/happy-1.15.ebuild,v 1.13 2006/08/26 20:41:12 wormo Exp $

CABAL_FEATURES="bin"
inherit base haskell-cabal autotools

DESCRIPTION="A yacc-like parser generator for Haskell"
HOMEPAGE="http://haskell.org/happy/"
SRC_URI="http://haskell.cs.yale.edu/happy/dist/${PV}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 sparc x86"
IUSE="doc"
#java use flag disabled, bug #107019

DEPEND=">=virtual/ghc-6.4.2
	>=dev-haskell/cabal-1.1.6.1
	doc? (  ~app-text/docbook-xml-dtd-4.2
		app-text/docbook-xsl-stylesheets )"
#		java? ( >=dev-java/fop-0.20.5 ) )"
RDEPEND=""

src_unpack() {
	base_src_unpack
	cd ${S}/doc && eautoconf
}

src_compile() {
	haskell-cabal_src_compile
	if use doc; then
		cd doc
		econf || die "econf failed in /doc"
		emake || die "emake failed in /doc"
	fi
}

src_install() {
	haskell-cabal_src_install
	use doc && cd doc && dohtml -r happy/*
}

