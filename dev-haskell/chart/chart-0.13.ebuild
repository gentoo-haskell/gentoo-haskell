# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="Chart"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A library for generating 2D Charts and Plots"
HOMEPAGE="http://www.dockerz.net/software/chart.html"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6
		>=dev-haskell/gtk2hs-0.9.11
		>=dev-haskell/colour-2.2.1
		=dev-haskell/data-accessor-0.2*
		<dev-haskell/data-accessor-template-0.3
		dev-haskell/mtl
		dev-haskell/time"

S="${WORKDIR}/${MY_P}"
