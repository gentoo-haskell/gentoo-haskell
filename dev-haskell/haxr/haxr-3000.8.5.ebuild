# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="XML-RPC client and server library."
HOMEPAGE="http://www.haskell.org/haskellwiki/HaXR"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="<dev-haskell/blaze-builder-0.4[profile?]
		dev-haskell/dataenc[profile?]
		>=dev-haskell/haxml-1.22[profile?]
		<dev-haskell/haxml-1.24[profile?]
		>=dev-haskell/http-4000[profile?]
		dev-haskell/mtl[profile?]
		<dev-haskell/network-3[profile?]
		dev-haskell/time[profile?]
		dev-haskell/utf8-string[profile?]
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	sed -e 's@HaXml == 1.22.\*@HaXml >= 1.22 \&\& < 1.24@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen dependencies"
}
