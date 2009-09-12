# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/haddock/haddock-2.4.1.ebuild,v 1.1 2009/07/23 20:15:07 kolmodin Exp $

CABAL_FEATURES="bin lib"
# don't enable profiling as the 'ghc' package is not built with profiling
inherit haskell-cabal autotools

GHCPATHS_PN="ghc-paths"
GHCPATHS_PV="0.1.0.5"
GHCPATHS_P="${GHCPATHS_PN}-${GHCPATHS_PV}"

DESCRIPTION="A documentation-generation tool for Haskell libraries"
HOMEPAGE="http://www.haskell.org/haddock/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz
	http://hackage.haskell.org/packages/archive/${GHCPATHS_PN}/${GHCPATHS_PV}/${GHCPATHS_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

# haddock-2.4.1 also deps on the upgradeable package dev-haskell/filepath.
# however, it's included in >=ghc-6.8.2, so we use the core package without
# stating the dependency in DEPEND.
# ghc-6.8.2 has filepath-1.1.0.0
# ghc-6.10.4 has filepath-1.1.0.2

# we bundle the dep on ghc-paths to reduce the dependencies on this critical
# package. ghc-paths would like to be compiled with USE=doc, which pulls in
# haddock, which requires ghc-paths, which pulls in haddock...
# bundling ghc-paths forces us to depend on >=cabal-1.6 rather than >=cabal-1.2

RDEPEND=">=dev-lang/ghc-6.8.2" # supports up to early ghc 6.10.x versions
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6
		doc? (  ~app-text/docbook-xml-dtd-4.2
				app-text/docbook-xsl-stylesheets
				>=dev-libs/libxslt-1.1.2 )"

src_unpack() {
	unpack ${A}

	# use ghc-paths directly, not as a library
	sed -e "s|build-depends: ghc-paths|hs-source-dirs: ../${GHCPATHS_P}|" \
		-e "s|Simple|Custom|" \
		-i "${S}/${PN}.cabal"

	# ghc-paths has a custom Setup.hs, haddock has the default Setup.lhs.
	# we use a somewhat modified ghc-paths Setup.hs that works better for our
	# purposes.
	rm "${S}/Setup.lhs"
	cp "${FILESDIR}/${PN}-2.4.2-Setup.hs" "${S}/Setup.hs"

	# -O2 is not needed and just prolongs compile time
	# missing module in other-modules declaration
	sed -e "s/-O2//" \
		-e 's/other-modules:/other-modules:\n    Haddock.DocName/' \
		-e 's/other-modules:/other-modules:\n    Haddock.GHC.Utils/' \
	    -i "${S}/${PN}.cabal"

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

