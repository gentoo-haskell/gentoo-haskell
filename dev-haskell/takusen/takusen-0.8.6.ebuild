# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

MY_PN="Takusen"
MY_P="${MY_PN}-${PV}"

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Database library with left-fold interface"
HOPACKAGE="http://code.haskell.org/takusen"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL"
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

