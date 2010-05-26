# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Snap: A Haskell Web Framework (Core)"
HOMEPAGE="http://snapframework.com/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

HASKELLDEPS=">=dev-haskell/attoparsec-0.8.0.2
		>=dev-haskell/bytestring-mmap-0.2.1
		dev-haskell/bytestring-nums
		=dev-haskell/cereal-0.2*
		=dev-haskell/dlist-0.5*
		>=dev-haskell/iteratee-0.3.1
		>=dev-haskell/monadcatchio-transformers-0.2.1
		dev-haskell/monads-fd
		>=dev-haskell/text-0.7.1
		dev-haskell/time
		dev-haskell/transformers
		dev-haskell/zlib"
RDEPEND=""
DEPEND=">=dev-haskell/cabal-1.6
		>=dev-lang/ghc-6.10
		${RDEPEND}
		${HASKELLDEPS}"
