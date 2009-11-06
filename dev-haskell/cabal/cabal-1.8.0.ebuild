# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="nocabaldep lib"
inherit haskell-cabal eutils

MY_PN="Cabal"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A framework for packaging Haskell software"
HOMEPAGE="http://www.haskell.org/cabal/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

# This ebuild is only a dummy, requires a 6.12 ghc
DEPEND=">=dev-lang/ghc-6.12"
RDEPEND="${DEPEND}"

CABAL_CORE_LIB_GHC_PV="6.12.0.20091010"
