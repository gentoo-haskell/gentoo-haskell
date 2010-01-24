# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="HList"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Heterogeneous lists"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/HList"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1"
DEPEND=">=dev-haskell/cabal-1.4
		${RDEPEND}"

S="${WORKDIR}/${MY_P}"
