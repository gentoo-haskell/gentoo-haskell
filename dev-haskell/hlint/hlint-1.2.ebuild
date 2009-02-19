# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Source code suggestions"
HOMEPAGE="http://www.cs.york.ac.uk/~ndm/hlint/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6
		dev-haskell/filepath
		=dev-haskell/haskell-src-exts-0.4.8*
		dev-haskell/mtl
		dev-haskell/syb
		>=dev-haskell/uniplate-1.2.0.2"
