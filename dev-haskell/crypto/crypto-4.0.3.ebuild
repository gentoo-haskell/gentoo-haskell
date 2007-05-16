# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"
inherit base haskell-cabal

DESCRIPTION="The Haskell Cryptographic Library"
HOMEPAGE="http://haskell.org/crypto/"
SRC_URI="http://www.haskell.org/crypto/downloads/Crypto-${PV}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.4
	>=dev-haskell/mtl-1.0"

S="${WORKDIR}/Crypto-${PV}"
