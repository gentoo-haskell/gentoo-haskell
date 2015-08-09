# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="Type-level programming library"
HOMEPAGE="http://code.haskell.org/type-level"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1"
DEPEND=">=dev-haskell/cabal-1.2
		${RDEPEND}"
