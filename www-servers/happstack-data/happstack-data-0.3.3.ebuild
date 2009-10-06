# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Happstack data manipulation libraries"
HOMEPAGE="http://happstack.com"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Use 6.10.1 to avoid worrying about sy as a dep
DEPEND=">=dev-lang/ghc-6.10.1
		dev-haskell/binary
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.6
		>=www-servers/happstack-util-0.3.2
		=dev-haskell/haxml-1.13*
		dev-haskell/hunit
		dev-haskell/mtl
		dev-haskell/syb
		>=dev-haskell/syb-with-class-0.5"
