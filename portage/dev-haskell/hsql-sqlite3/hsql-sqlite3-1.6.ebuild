# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit haskell-cabal

DESCRIPTION="SQLite3 bindings for Haskell"
HOMEPAGE="http://htoolkit.sourceforge.net/"
SRC_URI="mirror://sourceforge/htoolkit/HSQL-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="virtual/ghc
	=dev-haskell/hsql-${PV}
	>=dev-db/sqlite-3.0.0
	doc? ( dev-haskell/haddock )"

S=${WORKDIR}/HSQL-${PV}/SQLite3

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
