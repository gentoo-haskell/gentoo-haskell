# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/happy/happy-1.15.ebuild,v 1.13 2006/08/26 20:41:12 wormo Exp $

CABAL_FEATURES="bin"
inherit haskell-cabal autotools

DESCRIPTION="A yacc-like parser generator for Haskell"
HOMEPAGE="http://haskell.org/happy/"
SRC_URI="http://haskell.org/happy/dist/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=virtual/ghc-6.4
	>=dev-haskell/cabal-1.1.6.1
	doc? (  ~app-text/docbook-xml-dtd-4.2
		app-text/docbook-xsl-stylesheets )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}/doc && eautoconf
}

src_compile() {
	cabal_src_compile
	if use doc; then
		cd doc
		econf || die "econf failed in /doc"
		emake -j1 || die "emake failed in /doc"
	fi
}

src_install() {
	cabal_src_install
	use doc && cd doc && dohtml -r happy/*
}

