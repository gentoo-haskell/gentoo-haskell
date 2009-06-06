# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="An implementation of the OpenID-2.0 spec."
HOMEPAGE="http://github.com/elliottt/hsopenid"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		=dev-haskell/bytestring-0.9.1*
		>=dev-haskell/cabal-1.6
		=dev-haskell/hsopenssl-0.5*
		=dev-haskell/http-3001.1*
		=dev-haskell/monadlib-3.4.5*
		=dev-haskell/nano-hmac-0.2.0*
		=dev-haskell/network-2.2.0*
		=dev-haskell/time-1.1.2*
		=dev-haskell/xml-1.3.1*"

src_compile() {
    CABAL_CONFIGURE_FLAGS="--constraint=base<4"
    cabal_src_compile
}

