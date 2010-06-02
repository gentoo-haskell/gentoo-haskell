# Copyright 1999-2010 Gentoo Foundation
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

RDEPEND="|| (
			  ( =dev-lang/ghc-6.12* >=dev-haskell/syb-with-class-0.6.1 )
			  ( =dev-lang/ghc-6.10*  <dev-haskell/syb-with-class-0.6.1 )
		    )
		dev-haskell/binary
		=dev-haskell/happstack-util-0.5*
		=dev-haskell/haxml-1.13*
		dev-haskell/mtl
		dev-haskell/syb-with-class-instances-text
		>=dev-haskell/text-0.7.1
		>=dev-haskell/time-1.1.4"
DEPEND=">=dev-haskell/cabal-1.6
		${RDEPEND}"
