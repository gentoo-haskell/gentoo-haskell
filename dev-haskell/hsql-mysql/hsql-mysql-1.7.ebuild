# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hsql-mysql/hsql-mysql-1.7.ebuild,v 1.5 2006/03/09 17:44:15 dcoutts Exp $

CABAL_FEATURES="lib haddock"
inherit base haskell-cabal

DESCRIPTION="MySQL driver for HSQL"
HOMEPAGE="http://htoolkit.sourceforge.net/"
SRC_URI="mirror://gentoo/HSQL-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.4.1
	~dev-haskell/hsql-${PV}
	=dev-db/mysql-4*"

S="${WORKDIR}/HSQL/MySQL"

src_unpack() {
	base_src_unpack

	echo '> import Distribution.Simple' > "${S}/Setup.lhs"
	echo '> main = defaultMain' >> "${S}/Setup.lhs"

	sed -i '/cc-options:/d' "${S}/MySQL.cabal"
	echo 'extra-libraries: mysqlclient' >> "${S}/MySQL.cabal"
	echo 'ld-options: -L/usr/lib/mysql' >> "${S}/MySQL.cabal"
	echo 'include-dirs: Database/HSQL /usr/include/mysql' >> "${S}/MySQL.cabal"
}
