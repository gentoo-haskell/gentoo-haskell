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
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.4
	>=dev-haskell/mtl-1.0"
        dev-haskell/newbinary"

S=${WORKDIR}/Crypto-${PV}

src_unpack() {
	base_src_unpack

	# fix options pragma so it gets recognised
	sed -i 's/{-# OPTIONS -cpp #-}/> {-# OPTIONS -cpp #-}\n/' \
		"${S}/Gentoo/Private/NewBinary/FastMutInt.lhs"

	# don't build the test progs
	grep '^$' -B 1000 -m 1 "${S}/crypto.cabal" > "${S}/crypto.cabal.tmp"
	mv "${S}/crypto.cabal.tmp" "${S}/crypto.cabal"

	# drop unnecessary deps
	sed -i 's/, QuickCheck, HUnit//' "${S}/crypto.cabal"
}
