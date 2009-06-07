# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Reading, writing and manipulating ".tar" archive files."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/tar"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.${PN}.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.2
		dev-haskell/filepath"
