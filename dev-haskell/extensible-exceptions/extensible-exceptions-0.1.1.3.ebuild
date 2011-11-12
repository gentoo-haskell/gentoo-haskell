# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Extensible exceptions"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/extensible-exceptions"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.1"
DEPEND=">=dev-haskell/cabal-1.2.3
		${RDEPEND}"

CABAL_CORE_LIB_GHC_PV="7.2.1 7.2.2"
