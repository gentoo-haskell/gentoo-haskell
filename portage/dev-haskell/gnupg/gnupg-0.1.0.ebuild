# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="haddock"
inherit haskell-cabal

MY_PN=GnuPG
MY_P=${MY_PN}-${PV}

DESCRIPTION="Utilities for handling 'gpg'."
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/${MY_P}.tgz"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86"	#if possible try testing with "~amd64", "~ppc" and "~sparc"
IUSE=""

DEPEND=">=virtual/ghc-6.2.2"

S=${WORKDIR}/gpg
