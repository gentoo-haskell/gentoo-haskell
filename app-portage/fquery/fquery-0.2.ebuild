# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="A fast replacement for equery"
HOMEPAGE="http://home.exetel.com.au/tjaden/fquery/"
SRC_URI="http://home.exetel.com.au/tjaden/fquery/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.4"
RDEPEND=""
