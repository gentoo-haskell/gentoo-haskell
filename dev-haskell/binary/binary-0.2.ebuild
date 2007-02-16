# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib haddock"
inherit haskell-cabal

DESCRIPTION="Efficient, pure binary serialisation using lazy ByteStrings"
HOMEPAGE="http://darcs.haskell.org/binary/"
SRC_URI="http://hackage.haskell.org/packages/archive/binary/binary-0.2.tar.gz"

LICENSE="BSD3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.6"

S=${WORKDIR}/binary-0.2
