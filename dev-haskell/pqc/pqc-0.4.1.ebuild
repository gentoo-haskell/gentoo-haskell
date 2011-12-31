# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="haddock lib profile"
CABAL_MIN_VERSION=1.2
inherit haskell-cabal

DESCRIPTION="Parallel batch driver for QuickCheck"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/pqc.html"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-haskell/quickcheck"
