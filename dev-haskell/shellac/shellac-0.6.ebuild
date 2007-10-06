# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="haddock lib"
inherit haskell-cabal

DESCRIPTION="Shellac is a framework for building read-eval-print style shells"
HOMEPAGE="http://www.eecs.tufts.edu/~rdocki01/shellac.html"
SRC_URI="http://www.eecs.tufts.edu/~rdocki01/projects/${P}-source.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="readline"

DEPEND=">=dev-lang/ghc-6.4
		>=dev-haskell/mtl-1.0"

PDEPEND="readline? ( dev-haskell/shellac-readline )"

S="${WORKDIR}/${P}-source"
