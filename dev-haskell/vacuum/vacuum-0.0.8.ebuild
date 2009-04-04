# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Extract graph representations of ghc heap values."
HOMEPAGE="http://moonpatio.com/vacuum/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( (
                =dev-lang/ghc-6.10.1
                =dev-haskell/cabal-1.6.0.1
             )
             (
                =dev-lang/ghc-6.10.2
                =dev-haskell/cabal-1.6.0.3
             )
           )
		dev-haskell/ghc-paths
		dev-haskell/haskell-src-meta"
