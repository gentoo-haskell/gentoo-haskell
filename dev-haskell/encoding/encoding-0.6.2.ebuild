# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="A library for various character encodings"
HOMEPAGE="http://code.haskell.org/encoding/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# dcoutts reports that it needs haxml, despite not being listed in the .cabal file.
DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/binary
		>=dev-haskell/cabal-1.2
		dev-haskell/extensible-exceptions
		dev-haskell/mtl
		dev-haskell/regex-compat
		>=dev-haskell/haxml-1.19
		doc? ( >=dev-haskell/haddock-2.4.2 ) "
