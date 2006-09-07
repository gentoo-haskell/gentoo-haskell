# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bootstrap bin"
inherit haskell-cabal eutils versionator

MY_PF=$(replace_version_separator 3 '-' ${PF})

DESCRIPTION="A documentation tool for Haskell."
HOMEPAGE="http://haskell.org/haddock/"
SRC_URI="http://haskell.org/haddock/${MY_PF}-src.tar.gz"
LICENSE="as-is"
SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE="doc"

DEPEND=">=virtual/ghc-6.2
	doc? (  ~app-text/docbook-xml-dtd-4.2
		app-text/docbook-xsl-stylesheets
		>=dev-libs/libxslt-1.1.2 )"

S="${WORKDIR}/${MY_PF}"

src_compile () {
	cabal_src_compile
	if use doc; then
		cd ${S}/doc
		autoconf
		./configure --prefix=${D}/usr/ \
			|| die 'error configuring documentation.'
		make html || die 'error building documentation.'
	fi	
}

src_install () {
	cabal_src_install
	if use doc; then
		dohtml -r ${S}/doc/haddock/*
	fi
	dodoc CHANGES LICENSE README
}
