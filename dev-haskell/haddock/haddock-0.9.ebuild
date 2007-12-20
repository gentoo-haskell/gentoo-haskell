# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"
CABAL_MIN_VERSION=1.2
inherit haskell-cabal eutils autotools

DESCRIPTION="A documentation tool for Haskell."
HOMEPAGE="http://haskell.org/haddock/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"
LICENSE="BSD-2"
SLOT="0"

KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"

IUSE="doc"

DEPEND=">=dev-lang/ghc-6.4
		>=dev-haskell/cabal-1.1.4
	doc? (  ~app-text/docbook-xml-dtd-4.2
			app-text/docbook-xsl-stylesheets
			>=dev-libs/libxslt-1.1.2 )"
RDEPEND=""

src_compile () {
	cabal_src_compile
	if use doc; then
		cd "${S}/doc"
		eautoreconf
		./configure --prefix="${D}/usr/" \
			|| die 'error configuring documentation.'
		emake html || die 'error building documentation.'
	fi
}

src_install () {
	cabal_src_install
	if use doc; then
		dohtml -r "${S}/doc/haddock/"*
	fi
	dodoc CHANGES README
}
