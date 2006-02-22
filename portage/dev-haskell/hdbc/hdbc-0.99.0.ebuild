# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="haddock lib"
inherit haskell-cabal

DESCRIPTION="Haskell Database Connectivity"
HOMEPAGE="http://quux.org/devel/hdbc/"
SRC_URI="http://quux.org/devel/hdbc/${PN}_${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~x86 ~amd64"	#if possible try testing with "~ppc" and "~sparc"
IUSE="postgres sqlite odbc"

DEPEND=">=virtual/ghc-6.4.1"
PDEPEND="postgres? ( >=dev-haskell/hdbc-postgresql-${PV} )
		 sqlite? ( >=dev-haskell/hdbc-sqlite3-${PV} )
		 odbc? ( >=dev-haskell/hdbc-odbc-${PV} )"

S=${WORKDIR}/${PN}
