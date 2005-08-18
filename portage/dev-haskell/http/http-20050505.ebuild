# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="haddock"
inherit base eutils haskell-cabal

DESCRIPTION="Haskell HTTP Package"
HOMEPAGE="http://www.haskell.org/http/"
SRC_URI="http://www.haskell.org/http/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/ghc"

src_unpack() {
	base_src_unpack
	epatch ${FILESDIR}/cabalfix.patch
}
