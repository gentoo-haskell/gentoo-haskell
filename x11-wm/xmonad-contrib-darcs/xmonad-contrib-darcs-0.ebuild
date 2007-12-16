# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"

inherit haskell-cabal darcs

DESCRIPTION="Third party extentions for xmonad"
HOMEPAGE="http://www.xmonad.org/"
EDARCS_REPOSITORY="http://code.haskell.org/XMonadContrib"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-haskell/mtl-1.0
	x11-wm/xmonad-darcs
	>=dev-haskell/x11-xft-0.2
	dev-haskell/x11-darcs
	>=dev-lang/ghc-6.6"
RDEPEND="${DEPEND}"
