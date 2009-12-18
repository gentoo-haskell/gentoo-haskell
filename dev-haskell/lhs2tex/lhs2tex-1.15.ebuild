# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Preprocessor for typesetting Haskell sources with LaTeX"
HOMEPAGE="http://www.andres-loeh.de/lhs2tex/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6
		dev-haskell/extensible-exceptions
		dev-haskell/filepath
		dev-haskell/mtl
		dev-haskell/regex-compat
		dev-haskell/utf8-string"
		>=dev-tex/polytable-0.8.2
		doc? ( dev-lang/hugs98 virtual/latex-base )"

# one could argue that lhs2TeX RDEPENDs on tetex,
# but technically, it does not ...

src_unpack() {
	unpack ${A}
	pushd "${S}"
	use doc && rm doc/Guide2.dontbuild
	popd
}




