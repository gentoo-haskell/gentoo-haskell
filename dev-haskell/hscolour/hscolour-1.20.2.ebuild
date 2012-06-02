# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Colourise Haskell code."
HOMEPAGE="http://code.haskell.org/~malcolm/hscolour/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# Fails to build docs for dev-haskell/monad-control-0.3.1.3:
# HsColour: Char.intToDigit: not a digit 541
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_install() {
	cabal_src_install
	if use doc; then
		dohtml hscolour.css
	fi
}
