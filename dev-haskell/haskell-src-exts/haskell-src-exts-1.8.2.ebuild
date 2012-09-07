# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Manipulating Haskell source: abstract syntax, lexer, parser, and pretty-printer"
HOMEPAGE="http://code.haskell.org/haskell-src-exts"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""
RESTRICT="test"

RDEPEND=">=dev-lang/ghc-6.6.1
		 >=dev-haskell/cpphs-1.3"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2
		>=dev-haskell/happy-1.17"
