# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"

inherit haskell-cabal

DESCRIPTION="Third party extentions for xmonad"
HOMEPAGE="http://www.xmonad.org/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"

IUSE="xft utf8"

DEPEND="dev-haskell/mtl
	~x11-wm/xmonad-${PV}
	>=dev-lang/ghc-6.6
	>=dev-haskell/x11-1.4.1
	utf8? ( dev-haskell/utf8-string )
	xft?  ( dev-haskell/utf8-string
			dev-haskell/x11-xft )
	>=dev-haskell/cabal-1.2.1"
RDEPEND="${DEPEND}"

src_compile() {
	CABAL_CONFIGURE_FLAGS=""

	if use xft; then
		CABAL_CONFIGURE_FLAGS="--flags=use_xft"
	else
		CABAL_CONFIGURE_FLAGS="--flags=-use_xft"
	fi

	if use utf8; then
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=with_utf8"
	else
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=-with_utf8"
	fi
	cabal_src_compile
}
