# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal eutils

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
		~dev-haskell/protocol-buffers-0.3.1
		~dev-haskell/protocol-buffers-descriptor-0.3.1
		dev-haskell/quickcheck
		dev-haskell/utf8-string"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${PN}-0.2.9-genparser.patch"
}
