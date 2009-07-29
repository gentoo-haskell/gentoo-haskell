# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="message passing style helpers"
HOMEPAGE="http://github.com/nfjinjing/mps/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/bytestring-0.9
		>=dev-haskell/cabal-1.2
		dev-haskell/fgl
		>=app-text/pandoc-0.46
		dev-haskell/parallel
		>=dev-haskell/parsec-2
		dev-haskell/quickcheck
		>=dev-haskell/regexpr-0.2.9
		dev-haskell/time
		>=dev-haskell/utf8-string-0.3.1"
