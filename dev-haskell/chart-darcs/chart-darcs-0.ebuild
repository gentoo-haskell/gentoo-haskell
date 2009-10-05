# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
inherit darcs haskell-cabal

MY_PN="Chart"
MY_P="${MY_PN}-${PV}"

REPO_PN="chart"

DESCRIPTION="A library for generating 2D Charts and Plots"
HOMEPAGE="http://dockerz.net/twd/HaskellCharts"
EDARCS_REPOSITORY="http://www.dockerz.net/repos/${REPO_PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
		>=dev-haskell/cabal-1.6
		>=dev-haskell/data-accessor-0.2
		>=dev-haskell/data-accessor-template-0.2.1.1
		dev-haskell/mtl
		dev-haskell/time
		>=dev-haskell/gtk2hs-0.9.11
        >=dev-haskell/colour-2.2.1
		doc? ( >=dev-haskell/haddock-2 )"
