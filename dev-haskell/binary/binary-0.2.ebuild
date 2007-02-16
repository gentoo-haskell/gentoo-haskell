# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib haddock profile"
inherit haskell-cabal

DESCRIPTION="Efficient, pure binary serialisation using lazy ByteStrings"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/binary.html"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${P}.tar.gz"

LICENSE="BSD3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.6"
