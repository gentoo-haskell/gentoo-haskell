# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="A fast, iteratee-based, epoll-enabled web server for the Snap Framework"
HOMEPAGE="http://snapframework.com/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

HASKELLDEPS=">=dev-haskell/attoparsec-0.8.0.2
		=dev-haskell/attoparsec-iteratee-0.1*
		dev-haskell/bytestring-nums
		>=dev-haskell/bytestring-show-0.3.2
		=dev-haskell/cereal-0.2*
		dev-haskell/directory-tree
		=dev-haskell/dlist-0.5*
		>=dev-haskell/iteratee-0.3.1
		dev-haskell/monads-fd
		=dev-haskell/network-2.2.1*
		>=dev-haskell/network-bytestring-0.1.2
		>=dev-haskell/sendfile-0.6.1
		=dev-haskell/snap-core-0.2*
		dev-haskell/time
		dev-haskell/transformers
		=dev-haskell/vector-0.6*"
RDEPEND=">=dev-lang/ghc-6.8.1
		${HASKELLDEPS}"
DEPEND=">=dev-haskell/cabal-1.6
		${RDEPEND}"
