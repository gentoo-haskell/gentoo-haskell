# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"
inherit base haskell-cabal

DESCRIPTION="The Haskell Cryptographic Library"
HOMEPAGE="http://haskell.org/crypto/"
SRC_URI="http://www.haskell.org/crypto/downloads/Crypto-${PV}.tar.gz
		http://www.n-heptane.com/nhlab/NewBinary/NewBinary-2005-12-11.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.4"

S=${WORKDIR}/Crypto-${PV}

src_unpack() {
	base_src_unpack

	# make local private copy of NewBinary module
	mkdir -p "${S}/Gentoo/Private/NewBinary"
	mv "${WORKDIR}/NewBinary/NewBinary/Binary.hs" \
	   "${WORKDIR}/NewBinary/NewBinary/FastMutInt.lhs" \
	   "${S}/Gentoo/Private/NewBinary/"

	# fix up references to the private local NewBinary module
	sed -i 's/NewBinary/Gentoo.Private.NewBinary/' \
		"${S}/Gentoo/Private/NewBinary/Binary.hs" \
		"${S}/Gentoo/Private/NewBinary/FastMutInt.lhs" \
		"${S}/Codec/ASN1/TLV.hs"

	# fix options pragma so it gets recognised
	sed -i 's/{-# OPTIONS -cpp #-}/> {-# OPTIONS -cpp #-}\n/' \
		"${S}/Gentoo/Private/NewBinary/FastMutInt.lhs"

	# don't build the test progs
	grep '^$' -B 1000 -m 1 "${S}/crypto.cabal" > "${S}/crypto.cabal.tmp"
	mv "${S}/crypto.cabal.tmp" "${S}/crypto.cabal"

	# drop unnecessary deps
	sed -i 's/, QuickCheck, HUnit, NewBinary//' "${S}/crypto.cabal"
}
