# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="A liberalised cpp-a-like preprocessor for Haskell"
HOMEPAGE="http://haskell.org/cpphs/"
SRC_URI="http://www.cs.york.ac.uk/fp/cpphs/${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	cabal_src_install
	dohtml docs/index.html
	doman docs/cpphs.1
}
