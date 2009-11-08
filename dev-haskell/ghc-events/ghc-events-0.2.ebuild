# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Library and tool for parsing .eventlog files from GHC"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/ghc-events"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10
		=dev-haskell/binary-0.5*
		>=dev-haskell/cabal-1.6
		=dev-haskell/mtl-1.1*"
