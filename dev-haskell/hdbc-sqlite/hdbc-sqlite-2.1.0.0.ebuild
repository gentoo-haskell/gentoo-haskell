# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="HDBC-sqlite3"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Sqlite v3 driver for HDBC"
HOMEPAGE="http://software.complete.org/hdbc-sqlite3"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

hdbc_PV=$(get_version_component_range 1-2)

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.2.3
		dev-haskell/convertible
		dev-haskell/hunit
		dev-haskell/mtl
		dev-haskell/quickcheck
		dev-haskell/testpack
		dev-haskell/time
		dev-haskell/utf8-string
        =dev-haskell/hdbc-${hdbc_PV}*
        >=dev-db/sqlite-3.2"

S="${WORKDIR}/${MY_P}"
