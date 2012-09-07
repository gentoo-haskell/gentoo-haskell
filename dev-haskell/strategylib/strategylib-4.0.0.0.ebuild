# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal

MY_PN="StrategyLib"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="attempt to convert Strafunski's StrategyLib to a heirarchical library"
HOMEPAGE="http://naesten.dyndns.org:8080/repos/StrategyLib"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE=""	#Note: packages without a license cannot be included in portage
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		dev-haskell/mtl"

S="${WORKDIR}/${MY_P}"