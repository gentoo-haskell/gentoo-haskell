# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib haddock"
inherit darcs haskell-cabal

DESCRIPTION="A library for rendering 2D charts from haskell."
HOMEPAGE="http://dockerz.net/twd/HaskellCharts"
EDARCS_REPOSITORY="http://www.dockerz.net/repos/chart"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4
	>=dev-haskell/gtk2hs-0.9.11"

