# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib haddock"
inherit haskell-cabal

DESCRIPTION="Binary interface for haskell"
HOMEPAGE="http://www.n-heptane.com/nhlab/"
SRC_URI="http://www.n-heptane.com/nhlab/NewBinary-2005-08-21.tgz"

LICENSE="nhc98 GPL2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/ghc"

S=${WORKDIR}/NewBinary

