# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="haddock"
inherit haskell-cabal

DESCRIPTION="ODBC bindings for Haskell"
HOMEPAGE="http://htoolkit.sourceforge.net/"
SRC_URI="mirror://sourceforge/htoolkit/HSQL-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/ghc
	=dev-haskell/hsql-${PV}
	dev-db/libiodbc"

S=${WORKDIR}/HSQL-${PV}/ODBC

