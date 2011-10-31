# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="bin lib profile haddock"
inherit base haskell-cabal

DESCRIPTION="Colourise Haskell code."
HOMEPAGE="http://code.haskell.org/~malcolm/hscolour/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6"

src_install() {
	cabal_src_install
	if use doc; then
		dohtml hscolour.css
	fi
}
