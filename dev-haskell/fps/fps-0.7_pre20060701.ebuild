# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="haddock lib"
inherit base haskell-cabal versionator

MY_PV=$(get_version_component_range 1-2)
DESCRIPTION="Fast packed strings library"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/fps.html"
#SRC_URI="ftp://ftp.cse.unsw.edu.au/pub/users/dons/fps/${P}.tar.gz"
SRC_URI="http://dev.gentoo.org/~kosmikus/${P}.tar.gz"
LICENSE="BSD"
SLOT="${MY_PV}"

KEYWORDS="~x86"	#if possible try testing with "~amd64", "~ppc" and "~sparc"
IUSE=""

DEPEND=">=virtual/ghc-6.4.2"

S="${WORKDIR}/${PN}"

src_unpack() {
	base_src_unpack
	mv "${S}/fps.cabal.mmap" "${S}/fps.cabal"
}
