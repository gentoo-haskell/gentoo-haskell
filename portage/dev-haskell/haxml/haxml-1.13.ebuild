# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/haxml/haxml-1.12.ebuild,v 1.2 2005/04/05 16:23:19 kosmikus Exp $

CABAL_FEATURES="haddock"
inherit base haskell-cabal

MY_PN=HaXml
MY_P=${MY_PN}-${PV}

DESCRIPTION="Haskell utilities for parsing, filtering, transforming and generating XML documents"
HOMEPAGE="http://www.haskell.org/HaXml/"
SRC_URI="http://www.haskell.org/HaXml/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~x86"

IUSE="doc"

# actually, >=ghc-5.02 should be ok (if not using cabal)
# hugs and nhc98 are ok too, somebody might want to add support for them
DEPEND=">=virtual/ghc-6.2"

S=${WORKDIR}/${MY_P}

src_unpack() {
	base_src_unpack

	cd ${S}

	rm -rf src/Text/PrettyPrint
}

src_install() {
	cabal_src_install

	if use doc; then
		dohtml -r docs/*
		dodoc docs/icfp99.dvi docs/icfp99.ps.gz
	fi
}

