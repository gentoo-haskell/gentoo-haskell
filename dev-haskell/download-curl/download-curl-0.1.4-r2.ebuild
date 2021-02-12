# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# ebuild generated by hackport 0.2.17.9999

EAPI=6

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="High-level file download based on URLs"
HOMEPAGE="http://code.haskell.org/~dons/code/download-curl"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/curl:=[profile?]
	dev-haskell/feed:=[profile?]
	>=dev-haskell/tagsoup-0.8:=[profile?]
	dev-haskell/xml:=[profile?]
	>=dev-lang/ghc-6.8.2:="
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.2.0"

src_prepare() {
	default

	cabal_chdeps \
		'tagsoup >= 0.8 && < 0.13' 'tagsoup >= 0.8'
}
