# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="A parser generator for Haskell"
HOMEPAGE="http://www.informatik.uni-bonn.de/~ralf/frown/"
SRC_URI="http://www.informatik.uni-bonn.de/~ralf/frown/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=virtual/ghc-6.2.2"
RDEPEND=""

S="${WORKDIR}/Frown-${PV}"

src_unpack() {
	unpack ${A}
	# enabling optimisation is strongly recommended
	echo "ghc-options: -O" >> ${S}/frown.cabal
}

src_install() {
	cabal_src_install
	dohtml -r Manual/html
	dodoc COPYRIGHT Manual/Manual.ps
}
