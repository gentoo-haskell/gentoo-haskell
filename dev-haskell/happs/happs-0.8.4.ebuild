# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib haddock"
inherit base haskell-cabal

MY_PN="HAppS"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="HAppS is a Haskell framework for developing Internet services"
HOMEPAGE="http://happs.org/"
SRC_URI="http://happs.org/auto/${MY_P}.tar.gz"
LICENSE="BSD3"

SLOT="0"

IUSE="doc"

KEYWORDS="~x86"

DEPEND=">=virtual/ghc-6.6
	=dev-haskell/haxml-1.13*
	dev-haskell/mtl
	dev-haskell/network"
#can be built with ghc 6.4 too but then requires another .cabal file

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	base_src_unpack
	sed -i -e 's/hs-source-dir/hs-source-dirs/' "${S}/HAppS.cabal"
}

src_install() {
	haskell-cabal_src_install

	if use doc ; then
		dohtml doc/tutorial.html
	fi
}
