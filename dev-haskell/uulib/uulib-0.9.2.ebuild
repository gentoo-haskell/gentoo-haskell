# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="haddock cpphs lib"
inherit haskell-cabal

DESCRIPTION="The Utrecht University parsing, printing and DData libraries"
HOMEPAGE="http://www.cs.uu.nl/wiki/HUT/AttributeGrammarSystem"
SRC_URI="http://abaris.zoo.cs.uu.nl:8080/wiki/pub/HUT/Download/${P}-src.tar.gz"
LICENSE="LGPL-2.1-UUST"
SLOT="0"

KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"	#if possible try testing with ~ppc
IUSE=""

DEPEND=">=virtual/ghc-6.2.2
		>=dev-haskell/cpphs-0.9"

