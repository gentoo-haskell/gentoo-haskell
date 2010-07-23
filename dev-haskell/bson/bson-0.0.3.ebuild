# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="BSON documents are JSON-like objects with a standard binary encoding"
HOMEPAGE="http://github.com/TonyGen/bson-haskell"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/binary
		dev-haskell/compact-string-fix
		dev-haskell/data-binary-ieee754
		dev-haskell/mtl
		dev-haskell/nano-md5
		dev-haskell/network
		dev-haskell/time
		>=dev-lang/ghc-6.8.1"
DEPEND="${RDEPEND}
		dev-haskell/cabal"

