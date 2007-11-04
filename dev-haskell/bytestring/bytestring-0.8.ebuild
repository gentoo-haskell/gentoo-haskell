# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="haddock lib profile"
inherit haskell-cabal

DESCRIPTION="Fast, packed, strict and lazy byte arrays with a list interface"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/fps.html"
SRC_URI=""
LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND="=dev-lang/ghc-6.6*"

CABAL_CORE_LIB_GHC_PV="6.6.1"
