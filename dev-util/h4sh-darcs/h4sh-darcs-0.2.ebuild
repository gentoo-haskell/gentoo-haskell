# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin lib"

inherit darcs haskell-cabal ghc-package

DESCRIPTION="Provides a set of Haskell List functions as normal unix shell commands"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/h4sh.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

EDARCS_REPOSITORY="http://www.cse.unsw.edu.au/~dons/code/h4sh"
# Using --partial makes it go much faster and is recommended
# by the author of h4sh
EDARCS_GET_CMD="get --partial"

DEPEND="dev-lang/ghc
	>=dev-haskell/hs-plugins-0.9.10
	dev-haskell/fps"

src_compile() {
	# Build.hs will generate h4sh.cabal
	$(ghc-getghc) --make -o build Build.hs
	# build accepts mmap, packed and list
	./build mmap
	haskell-cabal_src_compile
}

src_install() {
	haskell-cabal_src_install
	dodoc AUTHORS HOWTO LICENSE DOC README
}
