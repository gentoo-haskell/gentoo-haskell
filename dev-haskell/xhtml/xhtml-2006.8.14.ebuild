# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

GHC_PV=6.5.20060907

DESCRIPTION="XHTML combinator library for haskell"
HOMEPAGE=""
SRC_URI="http://www.haskell.org/ghc/dist/current/dist/ghc-${GHC_PV}-src-extralibs.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=virtual/ghc-6.5*"

S="${WORKDIR}/ghc-${GHC_PV}/libraries/${PN}"

