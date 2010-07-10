# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib"
inherit haskell-cabal darcs

DESCRIPTION="A dependently typed programming language."
HOMEPAGE="http://appserv.cs.chalmers.se/users/ulfn/wiki/agda.php"

MY_PN="Agda"
MY_P="${MY_PN}-${PV}"


LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
	dev-haskell/mtl
	=dev-haskell/quickcheck-2*
	dev-haskell/haskell-src
	>=dev-haskell/binary-0.3
	>=dev-haskell/zlib-0.3
	>=dev-haskell/alex-2.0
	>=dev-haskell/happy-1.15"

S="${WORKDIR}/${P}"

EDARCS_REPOSITORY="http://www.cs.chalmers.se/~ulfn/darcs/Agda2"
EDARCS_GET_CMD="get --verbose"
EDARCS_LOCALREPO="Agda2"
