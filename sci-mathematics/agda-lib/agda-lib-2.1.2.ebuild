# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib"
inherit haskell-cabal

DESCRIPTION="A dependently typed programming language."
HOMEPAGE="http://appserv.cs.chalmers.se/users/ulfn/wiki/agda.php"

MY_PN="Agda"
MY_P="${MY_PN}-${PV}"

SRC_URI="http://www.cs.chalmers.se/~ulfn/darcs/Agda2/${MY_P}.tar.gz"
LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
	dev-haskell/mtl
	=dev-haskell/quickcheck-1*
	dev-haskell/haskell-src
	>=dev-haskell/binary-0.3
	>=dev-haskell/zlib-0.3"

S="${WORKDIR}/Agda2"
