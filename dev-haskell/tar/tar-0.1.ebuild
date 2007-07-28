# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile lib"
inherit haskell-cabal

DESCRIPTION="TAR (tape archive format) library."
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive//${PN}/${PV}/${P}.${PN}.gz"
LICENSE="BSD"
SLOT="0"

#if possible try testing with "~amd64", "~ppc", "~ppc64" and "~sparc"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.2.2
		>=dev-haskell/binary-0.2
		>=dev-haskell/unix-compat-0.1"
