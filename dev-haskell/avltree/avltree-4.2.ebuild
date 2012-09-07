# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

MY_PN="AvlTree"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Balanced binary trees using the AVL algorithm."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/AvlTree"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		>=dev-haskell/cordering-2.3"

S="${WORKDIR}/${MY_P}"
