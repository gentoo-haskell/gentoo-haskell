# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="haddock lib"
inherit base haskell-cabal

DESCRIPTION="Shellac is a framework for building read-eval-print style shells"
HOMEPAGE="http://www.eecs.tufts.edu/~rdocki01/shellac.html"
SRC_URI="http://www.eecs.tufts.edu/~rdocki01/projects/${P}-source.tar.gz"

LICENSE="BSD3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/ghc"
RDEPEND=""

src_unpack () {
	base_src_unpack
	cd ${WORKDIR}
	mv ${P}-source ${P}

}
