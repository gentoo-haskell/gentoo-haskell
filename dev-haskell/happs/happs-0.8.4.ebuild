# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib haddock"
inherit base haskell-cabal

MY_PN="HAppS"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://foo.bar.com/"
SRC_URI="http://happs.org/auto/${MY_P}.tar.gz"
LICENSE="BSD3"

SLOT="0"

IUSE="doc"

KEYWORDS="~x86"

DEPEND=">=virtual/ghc-6.6
	=dev-haskell/haxml-1.13*
	dev-haskell/mtl
	dev-haskell/network"

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
