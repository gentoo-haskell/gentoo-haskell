# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal

MY_PN="HAppS"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="HAppS is a Haskell framework for developing Internet services"
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
		=dev-haskell/haxml-1.13*
		dev-haskell/mtl
		dev-haskell/network
		dev-haskell/regex-compat"
#can be built with ghc 6.4 too but then requires another .cabal file

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"

	sed -i -e 's/hs-source-dir/hs-source-dirs/' "${S}/HAppS.cabal"
}

src_install() {
	cabal_src_install

	if use doc ; then
		dohtml doc/tutorial.html
	fi
}
