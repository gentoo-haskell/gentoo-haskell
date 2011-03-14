# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

# ebuild generated by hackport 0.2.13

EAPI="3"

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Parse Google Protocol Buffer specifications"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/protocol-buffers"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		dev-haskell/alex
		dev-haskell/binary
		>=dev-haskell/cabal-1.6
		>=dev-haskell/haskell-src-exts-1.7.0
		dev-haskell/mtl
		>=dev-haskell/parsec-2.1.0.1:0
		~dev-haskell/protocol-buffers-1.8.2
		~dev-haskell/protocol-buffers-descriptor-1.8.2
		dev-haskell/quickcheck
		dev-haskell/utf8-string
		>=dev-lang/ghc-6.10.1"

