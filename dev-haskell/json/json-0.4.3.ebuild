# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Support for serialising Haskell to and from JSON"
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# TODO: look into adding dep syb and allow other ghc versions
# syb is a core package of ghc-6.10.1, and was previously included in base

# enable map to dict?

DEPEND=">=dev-lang/ghc-6.10
		>=dev-haskell/cabal-1.2.0
		dev-haskell/mtl
		dev-haskell/parsec"

#DEPEND=">=dev-lang/ghc-6.6.1
#		>=dev-haskell/cabal-1.2.0
#		dev-haskell/mtl
#		dev-haskell/parsec
#		dev-haskell/syb"
