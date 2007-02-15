# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="haddock bin"
inherit haskell-cabal

DESCRIPTION="The Lambda Shell is a feature-rich shell environment and command-line tool for evaluating terms of the pure, untyped lambda calculus."
HOMEPAGE="http://www.eecs.tufts.edu/~rdocki01/lambda.html"
SRC_URI="http://www.eecs.tufts.edu/~rdocki01/projects/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/ghc
		>=dev-haskell/shellac-0.5
		dev-haskell/shellac-readline"

S="${WORKDIR}/${P}-source"
