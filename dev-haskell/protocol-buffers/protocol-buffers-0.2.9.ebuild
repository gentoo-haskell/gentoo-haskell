# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile" # TODO: needs haddock 2 for docs
inherit haskell-cabal

DESCRIPTION="Parse Google Protocol Buffer specifications"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/protocol-buffers"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/binary
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.2
		dev-haskell/filepath
		dev-haskell/haskell-src
		dev-haskell/mtl
		dev-haskell/parsec
		dev-haskell/quickcheck
		dev-haskell/utf8-string"

src_unpack() {
	unpack ${A}

	# building without -fvia-C makes GHC 6.8.3 break on my amd64
	# sed -i -e 's/-fvia-C//' "${S}/protocol-buffers.cabal"
}
