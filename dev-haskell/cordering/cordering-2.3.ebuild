# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

MY_PN="COrdering"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An algebraic data type similar to Prelude Ordering."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/COrdering"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2"

S="${WORKDIR}/${MY_P}"
