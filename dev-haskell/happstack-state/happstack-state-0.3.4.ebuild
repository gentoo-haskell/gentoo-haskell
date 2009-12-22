# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Event-based distributed state."
HOMEPAGE="http://happstack.com"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/binary
		>=dev-haskell/cabal-1.6
		dev-haskell/extensible-exceptions
		dev-haskell/filepath
		>=dev-haskell/happstack-data-0.3.2
		>=dev-haskell/happstack-util-0.3.2
		>=dev-haskell/hslogger-1.0.2
		>=dev-haskell/hspread-0.3
		dev-haskell/hunit
		dev-haskell/mtl
		dev-haskell/stm"
