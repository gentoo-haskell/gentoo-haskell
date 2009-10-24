# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal versionator

MY_PN="HDBC"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Haskell Database Connectivity"
HOMEPAGE="http://software.complete.org/hdbc"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="odbc postgres sqlite"

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		dev-haskell/mtl"

PDEPEND="odbc? ( =dev-haskell/hdbc-odbc-${PV}* )
		postgres? ( =dev-haskell/hdbc-postgresql-${PV}* )
		sqlite? ( =dev-haskell/hdbc-sqlite-${PV}* )"

S="${WORKDIR}/${MY_P}"
