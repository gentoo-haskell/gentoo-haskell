# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin lib haddock"
inherit haskell-cabal

DESCRIPTION="The Haskell Cryptographic Library"
HOMEPAGE="http://haskell.org/crypto/"
SRC_URI="http://haskell.org/crypto/src/Crypto-${PV}.tar.gz"

LICENSE="BSD GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4
	>=dev-haskell/newbinary-0.1-r1"

S=${WORKDIR}/Crypto-${PV}
