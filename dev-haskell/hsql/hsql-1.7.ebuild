# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hsql/hsql-1.7.ebuild,v 1.7 2006/03/11 21:31:06 dcoutts Exp $

CABAL_FEATURES="lib haddock"
inherit eutils haskell-cabal versionator

DESCRIPTION="SQL bindings for Haskell"
HOMEPAGE="http://htoolkit.sourceforge.net/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.1"

src_unpack() {
	unpack "${A}"

	cd ${S}
	epatch "${FILESDIR}/${P}-sqltext-to-int.patch"

	# Add in the extra split-base deps
	if version_is_at_least "6.8" "$(ghc-version)"; then
		sed -i -e '/build-depends:/a \
			, old-time' \
			-e '/extensions:/a \
			, Rank2Types, DeriveDataTypeable' \
		"${S}/hsql.cabal"
	fi
}

pkg_postinst () {
	ghc-package_pkg_postinst

	elog "You will probably want to emerge one or more HSQL backend."
	elog "These backends are available:"
	elog "		hsql-postgresql"
	elog "		hsql-mysql"
	elog "		hsql-sqlite"
	elog "		hsql-odbc"
}
