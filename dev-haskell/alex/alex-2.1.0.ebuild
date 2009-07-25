# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/alex/alex-2.1.0.ebuild,v 1.11 2008/01/26 20:24:10 dcoutts Exp $

CABAL_FEATURES="bin"
inherit autotools haskell-cabal

DESCRIPTION="A lexical analyser generator for Haskell"
HOMEPAGE="http://www.haskell.org/alex"
SRC_URI="http://www.haskell.org/alex/dist/${PV}/${P/_/}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 sparc x86"
IUSE="doc"

DEPEND=">=dev-lang/ghc-6.2
		=dev-haskell/cabal-1.1.6*
	doc? (	~app-text/docbook-xml-dtd-4.2
		app-text/docbook-xsl-stylesheets
		>=dev-libs/libxslt-1.1.2 )"
RDEPEND=""

src_unpack() {
	unpack ${A}

	if use doc; then
		cd "${S}/doc/"
		eautoreconf || die "eautoreconf for docs failed"
	fi
}

src_compile() {
	cabal_src_compile

	if use doc; then
		cd "${S}/doc/"
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
