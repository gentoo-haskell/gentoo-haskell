# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="HDBC"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Haskell Database Connectivity"
HOMEPAGE="http://software.complete.org/hdbc"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="odbc postgres sqlite"

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.2.3
		>=dev-haskell/convertible-1.0.1
		dev-haskell/hunit
		dev-haskell/mtl
		dev-haskell/quickcheck
		dev-haskell/testpack
		dev-haskell/time
		dev-haskell/utf8-string"

PDEPEND="odbc? ( =dev-haskell/hdbc-odbc-${PV}* )
        postgres? ( =dev-haskell/hdbc-postgresql-${PV}* )
        sqlite? ( =dev-haskell/hdbc-sqlite-${PV}* )"

S="${WORKDIR}/${MY_P}"
