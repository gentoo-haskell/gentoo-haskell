# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hdbc/hdbc-0.99.0.ebuild,v 1.5 2006/03/11 20:41:25 dcoutts Exp $

CABAL_FEATURES="lib haddock"
inherit ghc-package haskell-cabal

DESCRIPTION="Haskell Database Connectivity"
HOMEPAGE="http://quux.org/devel/hdbc/"
SRC_URI="http://quux.org/devel/hdbc/${PN}_${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.4.1"

S="${WORKDIR}/${PN}"

pkg_postinst () {
	ghc-package_pkg_postinst

	einfo "You will probably want to emerge one or more HDBC backend."
	einfo "These backends are available:"
	einfo "		hdbc-postgresql"
	einfo "		hdbc-sqlite"
	einfo "		hdbc-odbc"
}
