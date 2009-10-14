# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="wrapper for expat, the fast XML parser"
HOMEPAGE="http://haskell.org/haskellwiki/Hexpat/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.4
		=dev-haskell/extensible-exceptions-0.1*
		>=dev-haskell/mtl-1.1.0.0
		dev-haskell/parallel
		>=dev-haskell/text-0.5
		>=dev-haskell/utf8-string-0.3.3
		dev-libs/expat"
