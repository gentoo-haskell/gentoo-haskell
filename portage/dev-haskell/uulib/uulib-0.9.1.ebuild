# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="haddock cpphs"
inherit base haskell-cabal

DESCRIPTION="The Utrecht University parsing, printing and DData libraries"
HOMEPAGE="http://www.cs.uu.nl/wiki/HUT/AttributeGrammarSystem"
SRC_URI="http://abaris.zoo.cs.uu.nl:8080/wiki/pub/HUT/Download/${P}-src.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~x86"	#if possible try testing with "~amd64", "~ppc" and "~sparc"
IUSE=""

DEPEND=">=virtual/ghc-6.2.2
		>=dev-haskell/cpphs-0.9"

src_unpack() {
	base_src_unpack

	# fixes for cpp that comes with later versions of gcc.
	# it should really use cpphs instead.
	sed -i 's:infixl 9 \\\\:infixl 9 \\\\ --not a line continuation:' \
		"${S}/src/UU/DData/Set.hs"	\
		"${S}/src/UU/DData/MultiSet.hs" \
		"${S}/src/UU/DData/IntBag.hs"
	sed -i 's:infixl 9 !,\\\\:infixl 9 !,\\\\ --not a line continuation:' \
		"${S}/src/UU/DData/Map.hs"
}
