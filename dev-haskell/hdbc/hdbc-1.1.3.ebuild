# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hdbc/hdbc-0.99.0.ebuild,v 1.5 2006/03/11 20:41:25 dcoutts Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal versionator

MY_PN=HDBC
MY_P=${MY_PN}-${PV}

DESCRIPTION="Haskell Database Connectivity"
HOMEPAGE="http://software.complete.org/hdbc"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="odbc postgres sqlite"

DEPEND=">=dev-lang/ghc-6.4.1
		>=dev-haskell/mtl-1.0"

PDEPEND="odbc? ( =dev-haskell/hdbc-odbc-${PV}* )
		postgres? ( =dev-haskell/hdbc-postgresql-${PV}* )
		sqlite? ( =dev-haskell/hdbc-sqlite-${PV}* )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"

	sed -i -e '/GHC-Options:/d' "${S}/HDBC.cabal"

	if version_is_at_least "6.8" "$(ghc-version)"; then
		sed -i -e '/Build-Depends:/a \
			, old-time, containers, bytestring' \
		"${S}/HDBC.cabal"
		echo "GHC-Options: -fglasgow-exts" >> "${S}/HDBC.cabal"
	fi
}
