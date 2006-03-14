# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/lhs2tex/lhs2tex-1.10_pre.ebuild,v 1.5 2005/01/01 18:05:45 eradicator Exp $

CABAL_FEATURES="bin"
inherit haskell-cabal

SRC_URI="http://www.informatik.uni-bonn.de/~loeh/lhs2tex/${P/_pre/pre}.tar.bz2"

IUSE="doc"

DESCRIPTION="Preprocessor for typesetting Haskell sources with LaTeX"
HOMEPAGE="http://www.cs.uu.nl/~andres/lhs2tex"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

S="${WORKDIR}/${P/_pre/pre}"

DEPEND=">=dev-haskell/cabal-1.1.4_pre20060213
	>=dev-tex/polytable-0.8.2
	doc? ( dev-lang/hugs98 virtual/tetex )"

# one could argue that lhs2TeX RDEPENDs on tetex,
# but technically, it does not ...

src_unpack() {
	unpack ${A}
	cd ${S}
	use doc && rm doc/Guide2.dontbuild
}

