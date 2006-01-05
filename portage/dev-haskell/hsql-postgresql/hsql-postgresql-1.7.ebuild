# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib haddock"
inherit eutils base haskell-cabal

DESCRIPTION="PostgreSQL bindings for Haskell"
HOMEPAGE="http://htoolkit.sourceforge.net/"
SRC_URI="mirror://sourceforge/htoolkit/HSQL.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/ghc
	=dev-haskell/hsql-${PV}
	dev-db/libpq"

S=${WORKDIR}/HSQL/PostgreSQL

src_unpack() {
	base_src_unpack
	cd ${S}
	epatch ${FILESDIR}/setup-fix.diff
	epatch ${FILESDIR}/cabal-fix.diff
}
