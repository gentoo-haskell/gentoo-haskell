# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Runtime Haskell interpreter (GHC API wrapper)"
HOMEPAGE="http://projects.haskell.org/hint"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10.1
		>=dev-haskell/cabal-1.2.3
		dev-haskell/extensible-exceptions
		=dev-haskell/ghc-mtl-1.0*
		dev-haskell/ghc-paths
		dev-haskell/haskell-src
		>=dev-haskell/monadcatchio-mtl-0.2
		dev-haskell/mtl
		dev-haskell/utf8-string"
