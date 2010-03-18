# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Metadata collection for leksah"
HOMEPAGE="http://leksah.org"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10
		>=dev-haskell/cabal-1.6.0.1
		>=dev-haskell/binary-0.5.0.0
		>=dev-haskell/binary-shared-0.8
		>=dev-haskell/deepseq-1.1
		>=dev-haskell/haddock-leksah-2.5.0
		>=dev-haskell/hslogger-1.0.7
		>=dev-haskell/ltk-0.8
		>=dev-haskell/mtl-1.1.0.2
		>=dev-haskell/network-2.2
		>=dev-haskell/parsec-2.1.0.1
		>=dev-haskell/time-1.1"
RDEPEND=""
