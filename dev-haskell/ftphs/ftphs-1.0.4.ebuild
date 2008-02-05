# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal

DESCRIPTION="FTP Client and Server Library"
HOMEPAGE="http://software.complete.org/ftphs"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/cabal
		dev-haskell/network
		dev-haskell/parsec
		dev-haskell/mtl
		dev-haskell/regex-compat
		dev-haskell/hslogger
		>=dev-haskell/missingh-1.0.0"
