# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal

DESCRIPTION="Support for reading and writing UTF8 Strings"
HOMEPAGE="http://code.haskell.org/utf8-string/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86" #untested on sparc
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/cabal
		>=dev-haskell/bytestring-0.9"
