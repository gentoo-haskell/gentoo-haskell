# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock happy"
inherit haskell-cabal

DESCRIPTION="Manipulating Haskell source code"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		<dev-lang/ghc-7.0.1
		>=dev-haskell/cabal-1.2"
