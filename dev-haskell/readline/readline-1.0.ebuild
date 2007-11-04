# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="haddock lib profile"
inherit haskell-cabal

DESCRIPTION="An interface to the GNU readline library"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/readline"
SRC_URI=""
LICENSE="GPL-2.1"
SLOT="0"

KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND="<dev-lang/ghc-6.8"

CABAL_CORE_LIB_GHC_PV="6.4.2 6.6 6.6.1"
