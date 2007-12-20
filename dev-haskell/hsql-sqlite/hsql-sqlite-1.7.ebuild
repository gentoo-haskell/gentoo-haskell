# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib haddock"
inherit haskell-cabal

MY_PN=hsql-sqlite3
MY_P=${MY_PN}-${PV}

DESCRIPTION="SQLite3 driver HSQL"
HOMEPAGE="http://htoolkit.sourceforge.net/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.1
	~dev-haskell/hsql-${PV}
	>=dev-db/sqlite-3.0"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"

	cabal-mksetup
	echo 'extra-libraries: sqlite3' >> "${S}/hsql-sqlite3.cabal"
}
