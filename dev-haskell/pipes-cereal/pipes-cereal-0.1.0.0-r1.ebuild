# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Encode and decode binary streams using the pipes and cereal libraries"
HOMEPAGE="https://hackage.haskell.org/package/pipes-cereal"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/cereal-0.4:=[profile?]
	>=dev-haskell/mtl-2:=[profile?] <dev-haskell/mtl-3:=[profile?]
	>=dev-haskell/pipes-4:=[profile?] <dev-haskell/pipes-5:=[profile?]
	>=dev-haskell/pipes-bytestring-2:=[profile?] <dev-haskell/pipes-bytestring-3:=[profile?]
	>=dev-haskell/pipes-parse-3:=[profile?] <dev-haskell/pipes-parse-4:=[profile?]
	>=dev-lang/ghc-7.8.2:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
"

src_prepare() {
	default

	cabal_chdeps \
		'cereal >=0.4 && <0.5' 'cereal >=0.4'
}
