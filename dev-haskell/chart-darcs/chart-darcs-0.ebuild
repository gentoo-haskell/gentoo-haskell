# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
inherit darcs haskell-cabal

MY_PN="Chart"
MY_P="${MY_PN}-${PV}"

REPO_PN="chart"

DESCRIPTION="A library for generating 2D Charts and Plots"
HOMEPAGE="http://www.dockerz.net/software/chart.html"
EDARCS_REPOSITORY="http://www.dockerz.net/repos/${REPO_PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
		>=dev-haskell/cabal-1.2
		>=dev-haskell/gtk2hs-0.9.11"
