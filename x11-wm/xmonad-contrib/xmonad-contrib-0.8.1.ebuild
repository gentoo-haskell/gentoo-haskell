# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal eutils

DESCRIPTION="Third party extensions for xmonad"
HOMEPAGE="http://xmonad.org/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xft unicode"

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2.1
		dev-haskell/mtl
		>=dev-haskell/x11-1.4.3
		unicode? ( dev-haskell/utf8-string )
		xft? ( dev-haskell/utf8-string
			   >=dev-haskell/x11-xft-0.2 )
		~x11-wm/xmonad-${PV}"

RDEPEND="${DEPEND}"

src_compile() {
	if use xft; then
		CABAL_CONFIGURE_FLAGS="${CABAL_CONFIGURE_FLAGS} --flags=use_xft"
	else
		CABAL_CONFIGURE_FLAGS="${CABAL_CONFIGURE_FLAGS} --flags=-use_xft"
	fi

	if use unicode; then
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=with_utf8"
	else
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=-with_utf8"
	fi
	cabal_src_compile
}
