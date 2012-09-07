# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib"
# don't enable profiling as the 'ghc' package is not built with profiling
inherit haskell-cabal autotools

DESCRIPTION="A documentation-generation tool for Haskell libraries"
HOMEPAGE="http://www.haskell.org/haddock/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

# we bundle the dep on ghc-paths to reduce the dependencies on this critical
# package. ghc-paths would like to be compiled with USE=doc, which pulls in
# haddock, which requires ghc-paths, which pulls in haddock...

RDEPEND=">=dev-lang/ghc-6.8.2" # supports up to early ghc 6.10.x versions
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2
		doc? (  ~app-text/docbook-xml-dtd-4.2
				app-text/docbook-xsl-stylesheets
				>=dev-libs/libxslt-1.1.2 )"

src_unpack() {
	unpack ${A}

	# remove dependency on ghc-paths, we include it right into haddock instead
	sed -e "s|build-depends: ghc-paths|build-depends:|" \
		-i "${S}/${PN}.cabal"

	# copy of slightly modified version of GHC.Paths
	mkdir "${S}/src/GHC"
	cp "${FILESDIR}/ghc-paths-1.0.5.0-GHC-Paths.hs" "${S}/src/GHC/Paths.hs"

	# a few things we need to replace, and example values
	# GHC_PATHS_LIBDIR /usr/lib64/ghc-6.12.0.20091010
	# GHC_PATHS_DOCDIR /usr/share/doc/ghc-6.12.0.20091010/html
	# GHC_PATHS_GHC_PKG /usr/bin/ghc-pkg
	# GHC_PATHS_GHC /usr/bin/ghc (be careful: GHC_PATHS_GHC is a substring of GHC_PATHS_GHC_PKG)

	# hardcode stuff above:
	sed \
		-e "s|GHC_PATHS_LIBDIR|\"$(ghc-libdir)\"|" \
		-e "s|GHC_PATHS_DOCDIR|\"/usr/share/doc/ghc-$(ghc-version)/html\"|" \
		-e "s|GHC_PATHS_GHC_PKG|\"$(ghc-getghcpkg)\"|" \
		-e "s|GHC_PATHS_GHC|\"$(ghc-getghc)\"|" \
	  -i "${S}/src/GHC/Paths.hs"

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
