# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="An implementation of ghci using the Haskeline line-input library."
HOMEPAGE="http://code.haskell.org/~judah/ghci-haskeline"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		=dev-haskell/bytestring-0.9*
		>=dev-haskell/cabal-1.6
		>=dev-haskell/filepath-1
		dev-haskell/ghc-paths
		=dev-haskell/haskeline-0.6*
		dev-haskell/mtl"
