# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
CABAL_MIN_VERSION=1.2
inherit haskell-cabal

DESCRIPTION="XML-RPC client and server library."
HOMEPAGE="http://www.haskell.org/haxr/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		dev-haskell/mtl
		dev-haskell/network
		=dev-haskell/haxml-1.13*
		>=dev-haskell/http-1.0"
