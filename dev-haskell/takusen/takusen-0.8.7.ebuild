# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="bin lib profile haddock hscolour hoogle"
inherit base haskell-cabal

MY_PN="Takusen"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Database library with left-fold interface, for PostgreSQL, Oracle, SQLite, ODBC."
HOMEPAGE="http://hackage.haskell.org/package/Takusen"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="2"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="sqlite postgres odbc oracle"
# oracle should be buildable but I don't want to get an oracle db now, can't
# test without it

RDEPEND=">=dev-lang/ghc-6.12
		dev-haskell/mtl
		<dev-haskell/quickcheck-2
		dev-haskell/time
		sqlite? ( >=dev-db/sqlite-3 )
		postgres? ( dev-db/postgresql-base )
		odbc? ( dev-db/unixODBC ) "

DEPEND="${RDEPEND}
	   >=dev-haskell/cabal-1.2"

S="${WORKDIR}/${MY_P}"

CABAL_CONFIGURE_FLAGS="$(cabal_flag sqlite)
					   $(cabal_flag postgres)
					   $(cabal_flag oracle)
					   $(cabal_flag odbc)"

PATCHES=("${FILESDIR}/${MY_PN}-0.8.7-ghc-7.4.patch")
