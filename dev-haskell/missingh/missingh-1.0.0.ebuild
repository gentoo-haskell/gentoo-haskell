# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal versionator

MY_PN=MissingH
MY_P=${MY_PN}-${PV}

DESCRIPTION="A library of all sorts of utility functions for Haskell programmers."
HOMEPAGE="http://software.complete.org/missingh"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2" # mixed licence, all GPL compatible
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""
SLOT="0"

S="${WORKDIR}/${MY_P}"

DEPEND=">=dev-lang/ghc-6.6
	>=dev-haskell/hunit-1.1
	>=dev-haskell/filepath-1.0
	>=dev-haskell/hslogger-1.0.1
	>=dev-haskell/mtl-1.0
	>=dev-haskell/hunit-1.1
	>=dev-haskell/network-1.0
	>=dev-haskell/quickcheck-1.0
	dev-haskell/regex-compat"
