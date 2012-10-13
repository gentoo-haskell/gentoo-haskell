# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="HaskellDB support for HDBC."
HOMEPAGE="http://trac.haskell.org/haskelldb"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mysql odbc postgres sqlite3"

RDEPEND=">=dev-haskell/convertible-1.0.1[profile?]
		<dev-haskell/convertible-2[profile?]
		=dev-haskell/haskelldb-2*[profile?]
		=dev-haskell/hdbc-2*[profile?]
		>=dev-haskell/mtl-1[profile?]
		<dev-haskell/mtl-2.2[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"
PDEPEND="mysql? ( dev-haskell/haskelldb-hdbc-mysql[profile?] )
		odbc? ( =dev-haskell/haskelldb-hdbc-odbc-2*[profile?] )
		postgres? ( =dev-haskell/haskelldb-hdbc-postgresql-2*[profile?] )
		sqlite3? ( =dev-haskell/haskelldb-hdbc-sqlite3-2*[profile?] )"

src_prepare () {
	sed -e 's@mtl >= 1 && < 2.1@mtl >= 1 \&\& < 2.2@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen dependencies"
	sed -e 's@module Database.HaskellDB.HDBC (hdbcConnect) where@module Database.HaskellDB.HDBC (hdbcConnect, mkDatabase) where@' \
		-i "${S}/Database/HaskellDB/HDBC.hs" || die "could not export mkDatabase"
}
