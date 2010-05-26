# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Hackage and Portage integration tool"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/hackport"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

HASKELLDEPS="=dev-haskell/cabal-1.8*
		>=dev-haskell/http-4000.0.3
		dev-haskell/mtl
		dev-haskell/network
		dev-haskell/parsec
		dev-haskell/regex-compat
		dev-haskell/tar
		dev-haskell/zlib"
RDEPEND=""
DEPEND=">=dev-lang/ghc-6.10
		${RDEPEND}
		${HASKELLDEPS}"
