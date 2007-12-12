# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hdbc-odbc/hdbc-odbc-0.99.0.0.ebuild,v 1.5 2006/03/12 16:21:42 ranger Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal versionator

MY_PN=HDBC-odbc
MY_P=${MY_PN}-${PV}

DESCRIPTION="ODBC database driver for HDBC"
HOMEPAGE="http://software.complete.org/hdbc-odbc"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

hdbc_PV=$(get_version_component_range 1-3)

DEPEND=">=dev-lang/ghc-6.4.1
		dev-haskell/mtl
		=dev-haskell/hdbc-${hdbc_PV}*
		>=dev-db/unixODBC-2.2"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"

	cp "${FILESDIR}/hdbc-odbc-helper.h" "${S}/"

	cabal-mksetup
	echo "Extra-Libraries: odbc" >> "${S}/${MY_PN}.cabal"
	sed -i -e 's/GHC-Options: -O2 -Wall/GHC-Options: -fvia-C/' \
		 -e '/^Extensions:/a \
			, ForeignFunctionInterface' \
	 "${S}/${MY_PN}.cabal"

	if version_is_at_least "6.8" "$(ghc-version)"; then
		echo "GHC-Options: -XPatternSignatures" >> "${S}/${MY_PN}.cabal"
	fi
}
