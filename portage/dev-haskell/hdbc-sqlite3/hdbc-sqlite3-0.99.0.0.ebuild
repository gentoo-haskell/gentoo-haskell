# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="haddock lib"
inherit haskell-cabal

DESCRIPTION="HDBC module for sqlite"
HOMEPAGE="http://darcs.complete.org/hdbc-sqlite3/"
SRC_URI="http://quux.org/devel/hdbc/${PN}_${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~x86"	#if possible try testing with "~amd64", "~ppc" and "~sparc"
IUSE=""

DEPEND=">=virtual/ghc-6.2.2
	>=dev-haskell/hdbc-${PV}
	>=dev-db/sqlite-3.2.7"

S=${WORKDIR}/${PN}
