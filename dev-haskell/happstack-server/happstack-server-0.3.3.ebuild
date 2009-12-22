# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Web related tools and services."
HOMEPAGE="http://happstack.com"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6
		dev-haskell/extensible-exceptions
		>=dev-haskell/happstack-data-0.3.2
		>=dev-haskell/happstack-util-0.3.2
		=dev-haskell/haxml-1.13*
		>=dev-haskell/hslogger-1.0.2
		dev-haskell/html
		dev-haskell/hunit
		dev-haskell/maybet
		dev-haskell/mtl
		dev-haskell/network
		<dev-haskell/parsec-3
		dev-haskell/time
		>=dev-haskell/utf8-string-0.3.4
		dev-haskell/xhtml
		dev-haskell/zlib"
