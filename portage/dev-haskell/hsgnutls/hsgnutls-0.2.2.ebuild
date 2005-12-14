# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#Haddock doesn't work, because cabal has troubles with .chs files
#CABAL_FEATURES="lib haddock"
CABAL_FEATURES="lib"
inherit base haskell-cabal

DESCRIPTION="A haskell wrapper for the gnutls library."
HOMEPAGE="http://www.cs.helsinki.fi/u/ekarttun/hsgnutls/"
SRC_URI="http://www.cs.helsinki.fi/u/ekarttun/hsgnutls/${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-haskell/c2hs
	net-libs/gnutls"
RDEPEND=""

src_unpack() {
	base_src_unpack
	cd ${S}
	bash disable-network-alt.sh
}
