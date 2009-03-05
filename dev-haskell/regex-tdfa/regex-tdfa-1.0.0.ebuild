# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Replaces/Enhances Text.Regex"
HOMEPAGE="http://sourceforge.net/projects/lazy-regex"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.2.3
		dev-haskell/mtl
		dev-haskell/parsec
		>=dev-haskell/regex-base-0.93.1"

src_unpack() {
	unpack ${A}

	# remove broken haddock comment
	# type decalartions must not have haddock comments
	sed -e 's/\(type Tag = Int\).*/\1/' \
		-e 's/\(type Index = Int\).*/\1/' \
		-e 's/\(type SetIndex = IntSet\).*/\1/' \
		-e 's/\(type Position = Int\).*/\1/' \
	  -i "${S}/Text/Regex/TDFA/Common.hs"
}
