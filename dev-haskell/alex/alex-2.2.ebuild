# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/alex/alex-2.0.1-r1.ebuild,v 1.12 2006/10/05 03:47:46 cparrott Exp $

CABAL_FEATURES="bin"
CABAL_MIN_VERSION="1.2.1"
inherit autotools haskell-cabal

DESCRIPTION="A lexical analyser generator for Haskell"
HOMEPAGE="http://www.haskell.org/alex"
SRC_URI="http://www.haskell.org/alex/dist/${PV}/${P/_/}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"
# java use flag disabled because of bug #107019

DEPEND=">=dev-lang/ghc-6.2
	doc? (	~app-text/docbook-xml-dtd-4.2
		app-text/docbook-xsl-stylesheets
		>=dev-libs/libxslt-1.1.2 )"
# java? >=dev-java/fop-0.20.5
RDEPEND=""

src_compile() {
	cabal_src_compile

	if use doc; then
		cd "${S}/doc/"
		eautoreconf || die "eautoreconf for docs failed"
		econf || die "econf for docs failed"
		emake -j1 || die "emake for docs failed"
	fi
}

src_install() {
	cabal_src_install

	if use doc; then
		doman "${S}/doc/alex.1"
		dohtml -r "${S}/doc/alex/"
	fi
	dodoc README
}
