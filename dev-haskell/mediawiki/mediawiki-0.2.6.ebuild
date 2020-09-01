# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Interfacing with the MediaWiki API"
HOMEPAGE="https://hackage.haskell.org/package/mediawiki"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/http-3001:=[profile?]
	>=dev-haskell/mime-0.4:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/network-uri:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/utf8-string:=[profile?]
	dev-haskell/xml:=[profile?]
	>=dev-lang/ghc-6.10.4:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
"

PATCHES=( "${FILESDIR}"/${P}-mime-0.4.patch
		  "${FILESDIR}"/${P}-prelude-hiding.patch )

src_prepare() {
	default

	cabal_chdeps \
		'network' 'network, network-uri'
}
