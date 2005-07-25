# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit haskell-cabal

DESCRIPTION="PostgreSQL bindings for Haskell"
HOMEPAGE="http://htoolkit.sourceforge.net/"
SRC_URI="mirror://sourceforge/htoolkit/HSQL-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="virtual/ghc
	=dev-haskell/hsql-${PV}
	dev-db/postgresql
	doc? ( dev-haskell/haddock )"

S=${WORKDIR}/HSQL-${PV}/PostgreSQL

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
