# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=1

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="A simple terminal access library"
HOMEPAGE="http://trac.haskell.org/vty/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.10
		dev-haskell/mtl
		dev-haskell/parallel:1
		dev-haskell/parsec
		=dev-haskell/terminfo-0.3*
		=dev-haskell/utf8-string-0.3*
		=dev-haskell/vector-space-0.5*"

DEPEND="${RDEPEND}
		dev-haskell/cabal"
