# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib haddock"
inherit base haskell-cabal

DESCRIPTION="SQLite3 driver HSQL"
HOMEPAGE="http://htoolkit.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=virtual/ghc-6.4.1
	=dev-haskell/hsql-${PV}
	>=dev-db/sqlite-3.0"

S=${WORKDIR}/HSQL/SQLite3

src_unpack() {
	base_src_unpack
	cd ${S}

	echo '> import Distribution.Simple' > "${S}/Setup.lhs"
	echo '> main = defaultMain' >> "${S}/Setup.lhs"

	echo 'extra-libraries: sqlite3' >> "${S}/SQLite3.cabal"
}
