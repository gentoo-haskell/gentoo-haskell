# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal versionator

MY_PN="HDBC-postgresql"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PostgreSQL driver for HDBC"
HOMEPAGE="http://software.complete.org/hdbc-postgresql"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

hdbc_PV=$(get_version_component_range 1-3)

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		<dev-haskell/cabal-1.3
		dev-haskell/mtl
		=dev-haskell/hdbc-${hdbc_PV}*
		dev-haskell/parsec
		>=dev-db/libpq-8"

S="${WORKDIR}/${MY_P}"
