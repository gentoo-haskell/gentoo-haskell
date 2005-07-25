# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit haskell-cabal

DESCRIPTION="SQL bindings for Haskell"
HOMEPAGE="http://htoolkit.sourceforge.net/"
SRC_URI="mirror://sourceforge/htoolkit/HSQL-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc postgresql sqlite odbc"

DEPEND="virtual/ghc
	doc? ( dev-haskell/haddock )"

PDEPEND="postgresql? ( =dev-haskell/hsql-postgresql-${PV} )
	sqlite? ( =dev-haskell/hsql-sqlite3-${PV} )
	odbc? ( =dev-haskell/hsql-odbc-${PV} )"

S=${WORKDIR}/HSQL-${PV}/HSQL

src_compile() {
	cabal-bootstrap
	cabal-configure
	cabal-build
	if use doc; then
		cabal-haddock
	fi
}

src_install() {
	cabal-copy
	cabal-pkg
	if use doc; then
		dohtml dist/doc/html/*
	fi
}
