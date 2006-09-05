# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib haddock"
inherit haskell-cabal

DESCRIPTION="Binary serialisation library for Haskell"
HOMEPAGE="http://www.n-heptane.com/nhlab/"
SRC_URI="http://www.n-heptane.com/nhlab/NewBinary/NewBinary-2005-12-11.tar.gz"

LICENSE="nhc98 GPL2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.4"

S=${WORKDIR}/NewBinary

