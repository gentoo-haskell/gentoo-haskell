# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="AvlTree"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Balanced binary trees using AVL algorithm."
HOMEPAGE="http://www.haskell.org/haskellwiki/AvlTree"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		>=dev-haskell/cordering-2.1"

S="${WORKDIR}/${MY_P}"
