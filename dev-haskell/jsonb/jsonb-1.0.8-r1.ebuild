# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.3.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

MY_PN="JSONb"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="JSON parser that uses byte strings"
HOMEPAGE="https://github.com/solidsnack/JSONb/"
SRC_URI="https://hackage.haskell.org/package/${MY_P}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/attoparsec-0.10:=[profile?]
		>=dev-haskell/bytestring-nums-0.3.1:=[profile?]
		>=dev-haskell/bytestring-trie-0.1.4:=[profile?]
		>=dev-haskell/utf8-string-0.3:=[profile?]
		>=dev-lang/ghc-6.10.4:=[profile?]"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

S="${WORKDIR}/${MY_P}"

PATCHES=("${FILESDIR}"/${P}-bs-0.10.patch)
