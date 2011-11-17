# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="Ways to write a file cautiously, to reduce the chances of problems such as data loss due to crashes or power failures"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/cautious-file"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6"

RESTRICT="test"
# broken test suite; expects the package to be already installed
