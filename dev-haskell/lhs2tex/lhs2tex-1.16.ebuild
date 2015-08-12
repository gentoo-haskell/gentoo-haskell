# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="2"

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Preprocessor for typesetting Haskell sources with LaTeX"
HOMEPAGE="http://www.andres-loeh.de/lhs2tex/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=""
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		dev-haskell/mtl
		dev-haskell/regex-compat
		>=dev-lang/ghc-6.12
		>=dev-tex/polytable-0.8.2"

src_install() {
	haskell-cabal_src_install

	use doc || rm "${D}/usr/share/doc/${P}/doc/Guide2.pdf"
}
