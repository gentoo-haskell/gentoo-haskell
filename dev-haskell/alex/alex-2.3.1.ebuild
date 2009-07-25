# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/alex/alex-2.3.1.ebuild,v 1.4 2009/05/21 00:09:33 tcunha Exp $

CABAL_FEATURES="bin"
inherit autotools haskell-cabal

DESCRIPTION="Alex is a tool for generating lexical analysers in Haskell"
HOMEPAGE="http://www.haskell.org/alex/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc sparc x86"
# has worked with ppc64 too, but no ghc availably at the moment
IUSE="doc"

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
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
