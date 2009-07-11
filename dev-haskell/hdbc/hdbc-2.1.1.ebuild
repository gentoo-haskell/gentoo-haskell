# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal versionator

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
		>=dev-haskell/time-1.1.2.4
		dev-haskell/utf8-string"


DEPENDV="$(get_version_component_range 1-2)"
PDEPEND="odbc? ( =dev-haskell/hdbc-odbc-${DEPENDV}* )
        postgres? ( =dev-haskell/hdbc-postgresql-${DEPENDV}* )
        sqlite? ( =dev-haskell/hdbc-sqlite-${DEPENDV}* )"

S="${WORKDIR}/${MY_P}"
