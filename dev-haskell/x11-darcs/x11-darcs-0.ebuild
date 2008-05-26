# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal darcs autotools eutils

MY_PN=X11

DESCRIPTION="X11 bindings for haskell"
HOMEPAGE="http://haskell.org/ghc/"
EDARCS_REPOSITORY="http://darcs.haskell.org/X11"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE="xinerama"

DEPEND=">=dev-lang/ghc-6.4
		>=dev-haskell/cabal-1.1.6
		!dev-haskell/x11
		x11-libs/libX11"

src_unpack() {
	darcs_src_unpack

	cd "${S}"
	eautoreconf
}

src_compile() {
	CABAL_CONFIGURE_FLAGS="--configure-option=$(use_with xinerama)"
	cabal_src_compile
}
