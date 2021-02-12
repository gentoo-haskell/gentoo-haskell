# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Lambdabot miscellaneous plugins"
HOMEPAGE="https://wiki.haskell.org/Lambdabot"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/lambdabot-core-5.3:=[profile?] <dev-haskell/lambdabot-core-5.4:=[profile?]
	>=dev-haskell/lifted-base-0.2:=[profile?]
	>=dev-haskell/mtl-2:=[profile?]
	>=dev-haskell/network-2.7:=[profile?] <dev-haskell/network-3.2:=[profile?]
	>=dev-haskell/network-uri-2.6:=[profile?] <dev-haskell/network-uri-2.7:=[profile?]
	>=dev-haskell/parsec-3:=[profile?]
	>=dev-haskell/random-1:=[profile?]
	>=dev-haskell/random-fu-0.2.6.2:=[profile?]
	>=dev-haskell/random-source-0.3:=[profile?]
	>=dev-haskell/regex-tdfa-1.1:=[profile?]
	>=dev-haskell/safesemaphore-0.9:=[profile?]
	>=dev-haskell/split-0.2:=[profile?]
	>=dev-haskell/tagsoup-0.12:=[profile?]
	>=dev-haskell/transformers-base-0.4:=[profile?]
	>=dev-haskell/utf8-string-0.3:=[profile?]
	>=dev-haskell/zlib-0.5:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
"
