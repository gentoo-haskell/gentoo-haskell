# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="A Minimalistic Text Based Status Bar"
HOMEPAGE="http://gorgias.mine.nu/xmobar/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 -sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
		>=dev-haskell/cabal-1.2
		|| ( >=dev-haskell/x11-1.3.0 dev-haskell/x11-darcs )
		>=dev-haskell/mtl-1.0
		>=dev-haskell/filepath-1.0
		dev-haskell/parsec
		dev-haskell/stm"

src_unpack() {
	unpack ${A}

	# Cannot use -fasm on arches without a native code gen!
	# Don't need -Wall.
	# Portage does striping, package must not do it themselves.
	sed -i -e 's/-O2 -fasm -Wall -optl-Wl,-s//' "${S}/xmobar.cabal"
}

src_install() {
	cabal_src_install

	dodoc xmobar.config-sample README
}
