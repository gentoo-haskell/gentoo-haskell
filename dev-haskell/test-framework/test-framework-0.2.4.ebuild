# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit base haskell-cabal

DESCRIPTION="Framework for running and organising tests, with HUnit and QuickCheck support"
HOMEPAGE="http://batterseapower.github.com/test-framework/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/ansi-terminal-0.4.0
		>=dev-haskell/ansi-wl-pprint-0.4.0
		>=dev-haskell/cabal-1.2.3
		>=dev-haskell/extensible-exceptions-0.1.1
		>=dev-haskell/regex-posix-0.72"

src_unpack() {
	base_src_unpack

	# fix what seems to be a cabal bug.
	# dependency of an executable with Buildable:False are still required
	sed -e 's/HUnit >= 1.2,//' -i "${S}/${PN}.cabal"
}
