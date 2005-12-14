# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib haddock"
inherit base eutils haskell-cabal

DESCRIPTION="Binary interface for haskell"
HOMEPAGE="http://www.n-heptane.com/nhlab/"
SRC_URI="http://www.haskell.org/http/download/NewBinary-${PV}-ghc6.4.tar.gz"

LICENSE="nhc98"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/ghc"

S=${WORKDIR}/NewBinary

src_unpack() {
	base_src_unpack
	epatch ${FILESDIR}/cabalfix.patch
}
