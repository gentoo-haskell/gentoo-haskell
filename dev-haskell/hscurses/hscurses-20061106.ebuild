# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="haddock profile lib"
inherit eutils haskell-cabal

MY_P="${PN}-ds-${PV}"

DESCRIPTION="Haskell bindings for ncurses"
HOMEPAGE="http://www.informatik.uni-freiburg.de/~wehr/software/haskell/"
SRC_URI="http://www.informatik.uni-freiburg.de/~wehr/download/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.2
		sys-libs/ncurses"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-cpp-fix.patch"
	sed -i -e 's+HSCurses/+dist/build/HSCurses/+g' hscurses.cabal
}

src_compile() {
	fperms u+x configure
	cabal_src_compile
}
