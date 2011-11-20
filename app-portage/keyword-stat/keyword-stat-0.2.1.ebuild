# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Gentoo ebuild tool: list packages keywords"
HOMEPAGE="https://github.com/gentoo-haskell/keyword-stat"
SRC_URI="http://code.haskell.org/~kolmodin/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/cabal
		dev-haskell/pcre-light"
RDEPEND=""
