# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Web framework"
HOMEPAGE="http://happstack.com"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

HASKELLDEPS=">=dev-haskell/hslogger-1.0.2
		dev-haskell/mtl
		>=dev-haskell/network-2.2
		dev-haskell/parsec
		>=dev-haskell/smtpclient-1.0.2
		dev-haskell/strict-concurrency
		dev-haskell/time
		dev-haskell/unix-compat"
RDEPEND=">=dev-lang/ghc-6.10
		${HASKELLDEPS}"
DEPEND=">=dev-haskell/cabal-1.6
		${RDEPEND}"
