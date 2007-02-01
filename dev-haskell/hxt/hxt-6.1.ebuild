# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"
inherit base haskell-cabal

MY_PN="HXT"
MY_P=${MY_PN}-${PV}

DESCRIPTION="A collection of tools for processing XML with Haskell"
HOMEPAGE="http://www.fh-wedel.de/~si/HXmlToolbox/"
SRC_URI="http://www.fh-wedel.de/~si/HXmlToolbox/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.4
	>=dev-haskell/http-2006.7.7
	>=dev-haskell/hunit-1.1
	>=dev-haskell/network-1.0"

S=${WORKDIR}/${MY_P}

src_unpack() {
	base_src_unpack

	sed -i \
		-e 's/-O2/-O/' \
		"${S}/hxt.cabal"
}

src_install() {
	cabal_src_install

	dodoc LICENSE README
	if use doc; then
		cd ${S}/doc
		dodoc thesis.ps
		#dohtml -r *
	fi
}
