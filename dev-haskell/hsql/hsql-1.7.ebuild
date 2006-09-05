# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hsql/hsql-1.7.ebuild,v 1.7 2006/03/11 21:31:06 dcoutts Exp $

CABAL_FEATURES="lib haddock"
inherit base ghc-package haskell-cabal

DESCRIPTION="SQL bindings for Haskell"
HOMEPAGE="http://htoolkit.sourceforge.net/"
SRC_URI="mirror://gentoo/HSQL-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.4.1"

S="${WORKDIR}/HSQL/HSQL"

src_unpack() {
	base_src_unpack

	cd ${S}
	epatch "${FILESDIR}/${P}-sqltext-to-int.patch"
}

pkg_postinst () {
	ghc-package_pkg_postinst

	einfo "You will probably want to emerge one or more HSQL backend."
	einfo "These backends are available:"
	einfo "		hsql-postgresql"
	einfo "		hsql-mysql"
	einfo "		hsql-sqlite"
	einfo "		hsql-odbc"
}
