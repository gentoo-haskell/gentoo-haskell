# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib"
inherit base haskell-cabal

DESCRIPTION="Alternative network library for Haskell."
HOMEPAGE="http://www.cs.helsinki.fi/u/ekarttun/network-alt/"
SRC_URI="http://www.cs.helsinki.fi/u/ekarttun/network-alt/${P}.tar.gz"
LICENSE="BSD"
SLOT="${PV}"

KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=virtual/ghc-6.4.1
	>=dev-haskell/fps-0.7"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	cp cabal-files/select+fps.cabal .
	cabal_src_compile
}

