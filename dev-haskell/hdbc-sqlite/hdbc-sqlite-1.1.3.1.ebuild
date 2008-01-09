# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hdbc-sqlite/hdbc-sqlite-0.99.0.0.ebuild,v 1.5 2006/03/09 17:41:59 dcoutts Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal versionator

MY_PN=HDBC-sqlite3
MY_P=${MY_PN}-${PV}

DESCRIPTION="Sqlite v3 database driver for HDBC"
HOMEPAGE="http://software.complete.org/hdbc-sqlite3"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

hdbc_PV=$(get_version_component_range 1-3)

DEPEND=">=dev-lang/ghc-6.4.1
		dev-haskell/mtl
		=dev-haskell/hdbc-${hdbc_PV}*
		>=dev-db/sqlite-3.2"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"

	sed -i -e 's/GHC-Options: -O2 -Wall/GHC-Options: -fvia-C/' \
		-e '/^Extensions:/a \
		, ForeignFunctionInterface, EmptyDataDecls' \
		"${S}/${MY_PN}.cabal"

	if version_is_at_least "6.8" "$(ghc-version)"; then
		sed -i -e '/Build-Depends:/a \
			, bytestring' \
		"${S}/${MY_PN}.cabal"
		echo "GHC-Options: -XPatternSignatures" >> "${S}/${MY_PN}.cabal"
	fi
}
