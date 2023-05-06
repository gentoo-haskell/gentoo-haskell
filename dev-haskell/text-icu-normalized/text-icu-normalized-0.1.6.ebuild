# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.5.1

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Dealing with Strict Text in NFC normalization"
HOMEPAGE="https://gitlab.com/theunixman/text-icu-normalized"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-haskell/base-unicode-symbols:=[profile?]
	dev-haskell/lens:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/text-icu:=[profile?]
	>=dev-lang/ghc-7.10.1:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.22.2.0
"
