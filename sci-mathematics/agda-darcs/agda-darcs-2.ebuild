# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"
inherit haskell-cabal darcs

DESCRIPTION="A dependently typed programming languge"
HOMEPAGE="http://appserv.cs.chalmers.se/users/ulfn/wiki/agda.php"

MY_PN="Agda"
MY_P="${MY_PN}-${PV}"

#SRC_URI=""
LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
	dev-haskell/mtl
	=dev-haskell/quickcheck-2*
	dev-haskell/haskell-src
	>=dev-haskell/binary-0.3
	>=dev-haskell/zlib-0.3
	sci-mathematics/agda-lib-darcs"

S="${WORKDIR}/${P}/src/main"

EDARCS_REPOSITORY="http://www.cs.chalmers.se/~ulfn/darcs/Agda2"
EDARCS_GET_CMD="get --verbose"
EDARCS_LOCALREPO="Agda2"
