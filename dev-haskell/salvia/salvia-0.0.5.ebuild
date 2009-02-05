# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Lightweight Haskell Web Server Framework"
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/bimap
		dev-haskell/bytestring
		dev-haskell/cabal
		dev-haskell/clevercss
		dev-haskell/encoding
		dev-haskell/filepath
		dev-haskell/hscolour
		~dev-haskell/mtl-1.1.0.2
		dev-haskell/nano-md5
		dev-haskell/network
		<dev-haskell/parsec-3
		dev-haskell/stm
		dev-haskell/time
		dev-haskell/utf8-string"

src_unpack() {
	unpack ${A}

	sed -e 's/parsec/parsec<3/' \
	  -i "${S}/${PN}.cabal"
}
