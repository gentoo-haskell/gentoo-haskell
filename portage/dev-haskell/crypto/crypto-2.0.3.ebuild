# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="haddock"
inherit haskell-cabal

DESCRIPTION="Haskell Crypto Package"
HOMEPAGE="http://haskell.org/crypto/"
SRC_URI="http://www.haskell.org/crypto/src/Crypto-${PV}.tar.gz"

LICENSE="BSD GPL"
SLOT="${PV}"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/ghc
	>=dev-haskell/newbinary-0.1"

S=${WORKDIR}/Crypto-${PV}

