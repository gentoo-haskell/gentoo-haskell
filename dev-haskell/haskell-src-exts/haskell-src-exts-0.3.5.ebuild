# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile happy"
inherit haskell-cabal

DESCRIPTION="An extension to haskell-src that handles most common syntactic extensions to Haskell"
HOMEPAGE="http://code.haskell.org/HSP/haskell-src-exts/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.8.2
		>=dev-haskell/cabal-1.2"
