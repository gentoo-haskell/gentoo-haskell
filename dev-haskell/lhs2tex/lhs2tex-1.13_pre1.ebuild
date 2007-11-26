# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"
CABAL_CONFIGURE_FLAGS="--datasubdir=${P}"
inherit eutils haskell-cabal

SRC_URI="http://www.informatik.uni-bonn.de/~loeh/lhs2tex/${P/_pre/pre}.tar.bz2"

IUSE="doc"

DESCRIPTION="Preprocessor for typesetting Haskell sources with LaTeX"
HOMEPAGE="http://www.informatik.uni-bonn.de/~loeh/lhs2tex"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

S="${WORKDIR}/${P/_pre/pre}"

DEPEND=">=dev-haskell/cabal-1.1.6
	>=dev-haskell/regex-compat-0.71
	dev-haskell/mtl
	dev-haskell/filepath
	>=dev-tex/polytable-0.8.2
	doc? ( dev-lang/hugs98 virtual/tetex )"

# one could argue that lhs2TeX RDEPENDs on tetex,
# but technically, it does not ...

src_unpack() {
	unpack ${A}
	pushd ${S}
	use doc && rm doc/Guide2.dontbuild
	popd
}

