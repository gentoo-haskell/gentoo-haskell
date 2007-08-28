# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Podcast Aggregator (downloader)"
HOMEPAGE="http://software.complete.org/hpodder"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		dev-haskell/network
		>=dev-haskell/missingh-0.18.0
		>=dev-haskell/hdbc-1.1.0
		>=dev-haskell/hdbc-sqlite-1.1.0
		dev-haskell/mtl
		>=dev-haskell/haxml-1.13.2
		dev-haskell/hslogger
		dev-haskell/configfile
		dev-haskell/filepath"
