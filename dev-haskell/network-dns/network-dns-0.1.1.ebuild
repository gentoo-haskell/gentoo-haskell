# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="A pure Haskell, asyncronous DNS client library"
HOMEPAGE="http://darcs.imperialviolet.org/network-dns"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/cabal
		>=dev-haskell/bytestring-0.9
		>=dev-haskell/binary-strict-0.2.4
		>=dev-haskell/control-timeout-0.1.2
		>=dev-haskell/network-2.1
		dev-haskell/network-bytestring
		>=dev-haskell/binary-0.4.1
		>=dev-haskell/parsec-2.1
		>=dev-haskell/stm-2.1
		>=dev-haskell/time-1.1"
