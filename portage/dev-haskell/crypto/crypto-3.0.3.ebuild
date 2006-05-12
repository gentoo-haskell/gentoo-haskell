# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin lib haddock"
inherit haskell-cabal

DESCRIPTION="The Haskell Cryptographic Library"
HOMEPAGE="http://haskell.org/crypto/"
SRC_URI="http://www.haskell.org/crypto/downloads/Crypto-${PV}.tar.gz"

LICENSE="BSD GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.4
	>=dev-haskell/newbinary-0.1-r1"

S=${WORKDIR}/Crypto-${PV}

src_install() {
	haskell-cabal_src_install

	# remove the tests and examples
	rm -r "${D}/usr/bin"
}
