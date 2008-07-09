# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="haddock lib profile"
inherit haskell-cabal

GHC_PV=6.8.3

DESCRIPTION="POSIX functionality"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/unix"
SRC_URI="http://www.haskell.org/ghc/dist/${GHC_PV}/ghc-${GHC_PV}-src.tar.bz2"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6"

CABAL_CORE_LIB_GHC_PV="6.8.3"

S="${WORKDIR}/ghc-${GHC_PV}/libraries/${PN}"
