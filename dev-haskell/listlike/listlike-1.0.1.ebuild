# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="ListLike"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Generic support for list-like structures"
HOMEPAGE="http://software.complete.org/listlike"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		 dev-haskell/mtl"
DEPEND="dev-haskell/cabal
		${RDEPEND}"

S="${WORKDIR}/${MY_P}"
