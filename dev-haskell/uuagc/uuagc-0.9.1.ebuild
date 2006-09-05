# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="The Utrecht University Attribute Grammar system"
HOMEPAGE="http://www.cs.uu.nl/wiki/HUT/AttributeGrammarSystem"
SRC_URI="http://abaris.zoo.cs.uu.nl:8080/wiki/pub/HUT/Download/${P}-src.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc64 ~sparc ~x86" #if possible try testing with ~ppc
IUSE=""

DEPEND=">=virtual/ghc-6.2.2
		>=dev-haskell/uulib-0.9.1"
