# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Web related tools and services."
HOMEPAGE="http://happstack.com"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.2.3
		dev-haskell/extensible-exceptions
		www-servers/happstack-data
		www-servers/happstack-ixset
		www-servers/happstack-state
		www-servers/happstack-util
		=dev-haskell/haxml-1.13*
		>=dev-haskell/hslogger-1.0.2
		dev-haskell/html
		dev-haskell/hunit
		dev-haskell/mtl
		dev-haskell/network
		<dev-haskell/parsec-3
		dev-haskell/syb
		dev-haskell/xhtml"

src_compile() {
	CABAL_CONFIGURE_FLAGS='--flags=-tests'
	cabal_src_compile
}
