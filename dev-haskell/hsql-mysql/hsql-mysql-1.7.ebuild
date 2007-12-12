# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hsql-mysql/hsql-mysql-1.7.ebuild,v 1.5 2006/03/09 17:44:15 dcoutts Exp $

CABAL_FEATURES="lib haddock"
inherit haskell-cabal versionator

DESCRIPTION="MySQL driver for HSQL"
HOMEPAGE="http://htoolkit.sourceforge.net/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.1
	~dev-haskell/hsql-${PV}
	>=virtual/mysql-4.0"

src_unpack() {
	unpack "${A}"

	cabal-mksetup
	sed -i '/cc-options:/d' "${S}/${PN}.cabal"
	echo 'extra-libraries: mysqlclient' >> "${S}/${PN}.cabal"
	echo 'ld-options: -L/usr/lib/mysql' >> "${S}/${PN}.cabal"
	echo 'include-dirs: Database/HSQL /usr/include/mysql' >> "${S}/${PN}.cabal"

	# Add in the extra split-base deps
	if version_is_at_least "6.8" "$(ghc-version)"; then
		echo "build-depends: old-time" >> "${S}/${PN}.cabal"
	fi
}
