# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin lib haddock"

inherit base haskell-cabal

DESCRIPTION="Hpc is a tool-kit to record and display Haskell program coverage."
HOMEPAGE="http://projects.unsafeperformio.com/hpc/"
SRC_URI="http://projects.unsafeperformio.com/hpc/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6"
RDEPEND="${DEPEND}
	dev-haskell/hmake"

src_install() {
	haskell-cabal_src_install

	dobin bin/hpc-build
}
