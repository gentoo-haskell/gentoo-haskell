# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal autotools

# we bundle mtl as we want fewer dependencies for haddock, which require happy
# mtl needs haddock to be compiled with USE=doc
MTL_PN="mtl"
MTL_PV="1.1.0.2"
MTL_P="${MTL_PN}-${MTL_PV}"

DESCRIPTION="Happy is a parser generator for Haskell"
HOMEPAGE="http://www.haskell.org/happy/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz
		 http://hackage.haskell.org/packages/archive/${MTL_PN}/${MTL_PV}/${MTL_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2.3
		doc? (  ~app-text/docbook-xml-dtd-4.2
				app-text/docbook-xsl-stylesheets )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}/doc" && eautoconf

	# change happy.cabal to use bundled mtl
	# remove dep on mtl, add path
	sed -e "s|, mtl >= 1.0||" \
	    -e "s|hs-source-dirs: src|hs-source-dirs: src, ../mtl-1.1.0.2|" \
		-i "${S}/${PN}.cabal"
	# compile happy with the extensions mtl uses (safe?)
	# this gives repoman whitespace warnings, ignore them
	cat >> "${S}/${PN}.cabal" << EOF
  extensions: MultiParamTypeClasses,
              FunctionalDependencies,
              FlexibleInstances,
              TypeSynonymInstances
EOF
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
