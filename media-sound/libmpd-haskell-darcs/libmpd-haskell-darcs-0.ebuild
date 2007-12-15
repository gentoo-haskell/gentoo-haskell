# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"

inherit haskell-cabal darcs

DESCRIPTION="An MPD Client Library"
HOMEPAGE="http://turing.enu.edu.au/~bsinclai/code/libmpd-haskell.html"
EDARCS_REPOSITORY="http://turing.une.edu.au/~bsinclai/code/libmpd-haskell"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-haskell/mtl-1.0
		dev-haskell/network
		>=dev-lang/ghc-6.4"
RDEPEND="${DEPEND}"

src_install() {
  dodoc ChangeLog README TODO
}
