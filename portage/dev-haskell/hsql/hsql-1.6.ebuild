# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib haddock"
inherit haskell-cabal

DESCRIPTION="SQL bindings for Haskell"
HOMEPAGE="http://htoolkit.sourceforge.net/"
SRC_URI="mirror://sourceforge/htoolkit/HSQL-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="postgres sqlite odbc"

DEPEND="virtual/ghc"

PDEPEND="postgres? ( =dev-haskell/hsql-postgresql-${PV} )
	sqlite? ( =dev-haskell/hsql-sqlite3-${PV} )
	odbc? ( =dev-haskell/hsql-odbc-${PV} )"

S=${WORKDIR}/HSQL-${PV}/HSQL

