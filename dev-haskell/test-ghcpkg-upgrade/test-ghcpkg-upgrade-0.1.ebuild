# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib"
inherit haskell-cabal

DESCRIPTION="A simple test for the (un-)register functions"
HOMEPAGE=""
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/ghc"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
	cp "${FILESDIR}"/test-ghcpkg-upgrade.cabal "${S}"
	cp "${FILESDIR}"/Setup.hs "${S}"
	cp "${FILESDIR}"/Dummy.hs "${S}"
}
