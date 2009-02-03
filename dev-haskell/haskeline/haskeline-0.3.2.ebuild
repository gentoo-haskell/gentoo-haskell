# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="A command-line interface for user input, written in Haskell."
HOMEPAGE="http://trac.haskell.org/haskeline"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/bytestring-0.9.0.1
		>=dev-haskell/cabal-1.2
		>=dev-haskell/filepath-1.1
		>=dev-haskell/mtl-1.1
		>=dev-haskell/stm-2.0
		>=dev-haskell/terminfo-0.2.2
		>=dev-haskell/utf8-string-0.3.1.1"
