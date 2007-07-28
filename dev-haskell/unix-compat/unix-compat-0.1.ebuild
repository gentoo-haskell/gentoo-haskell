# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal

DESCRIPTION="Portable POSIX-compatibility layer."
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive//${PN}/${PV}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"

#if possible try testing with "~amd64", "~ppc", "~ppc64" and "~sparc"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.2.2"
