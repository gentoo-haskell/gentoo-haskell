# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Track application of Darcs patches"
HOMEPAGE="http://darcswatch.nomeata.de/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

HASKELLDEPS="dev-haskell/cgi
		dev-haskell/concurrentoutput
		dev-haskell/crypto
		>=dev-haskell/http-4000
		dev-haskell/mime-string
		dev-haskell/mtl
		dev-haskell/nano-md5
		dev-haskell/network
		dev-haskell/parsec
		dev-haskell/regex-compat
		dev-haskell/time
		dev-haskell/xhtml
		dev-haskell/zlib"
RDEPEND=""
DEPEND=">=dev-haskell/cabal-1.6
		>=dev-lang/ghc-6.8.1
		${HASKELLDEPS}"
