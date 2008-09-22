# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock"
CABAL_MIN_VERSION="1.2"
inherit haskell-cabal

DESCRIPTION="Conversion between markup formats"
HOMEPAGE="http://johnmacfarlane.net/pandoc"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/bytestring-0.9
		>=dev-haskell/filepath-1.1
		>=dev-haskell/mtl-1.1
		>=dev-haskell/network-2
		=dev-haskell/parsec-2.1*
		>=dev-haskell/utf8-string-0.3
		>=dev-haskell/xhtml-3000.0
		>=dev-haskell/zip-archive-0.1.1"
