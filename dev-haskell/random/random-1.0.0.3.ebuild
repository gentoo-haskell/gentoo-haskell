# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

# PDEPEND of ghc, so restrict depgraph
CABAL_FEATURES="lib profile nocabaldep"
inherit haskell-cabal

DESCRIPTION="random number library"
HOMEPAGE="http://hackage.haskell.org/package/random"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}"

CABAL_CORE_LIB_GHC_PV="7.0.1 7.0.2 7.0.3 7.0.4"
