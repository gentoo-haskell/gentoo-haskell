# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

MY_PN="lambdaFeed"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="RSS 2.0 feed generator"
HOMEPAGE="http://www.cse.unsw.edu.au/~chak/haskell/lambdaFeed/"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		dev-haskell/html"

S="${WORKDIR}/${MY_P}"
