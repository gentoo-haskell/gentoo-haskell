# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Framework for running and organising tests, with HUnit and QuickCheck support"
HOMEPAGE="http://batterseapower.github.com/test-framework/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

HASKELLDEPS=">=dev-haskell/ansi-terminal-0.4.0
		>=dev-haskell/ansi-wl-pprint-0.5.1
		>=dev-haskell/extensible-exceptions-0.1.1
		>=dev-haskell/hostname-1.0
		>=dev-haskell/regex-posix-0.72
		>=dev-haskell/time-1.1.4
		>=dev-haskell/xml-1.3.5"
RDEPEND=">=dev-lang/ghc-6.8.1
		${HASKELLDEPS}"
DEPEND=">=dev-haskell/cabal-1.2.3
		${RDEPEND}"
