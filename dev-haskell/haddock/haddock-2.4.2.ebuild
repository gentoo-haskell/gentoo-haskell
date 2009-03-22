# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib"
# don't enable profiling as the 'ghc' package is not built with profiling
inherit haskell-cabal autotools

DESCRIPTION="A documentation-generation tool for Haskell libraries"
HOMEPAGE="http://www.haskell.org/haddock/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/ghc-6.8.2
		>=dev-haskell/cabal-1.5
		dev-haskell/filepath
		dev-haskell/ghc-paths
        doc? (  ~app-text/docbook-xml-dtd-4.2
                app-text/docbook-xsl-stylesheets
                >=dev-libs/libxslt-1.1.2 )"

src_unpack() {
	unpack ${A}

	if use doc; then
	  cd "${S}/doc"
	  eautoreconf
	fi

}

src_compile () {
	cabal_src_compile
	if use doc; then
		cd "${S}/doc"
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

