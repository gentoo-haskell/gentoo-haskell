# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A driver for Redis key-value database"
HOMEPAGE="http://hub.darcs.net/ganesh/redis"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-haskell/concurrent-extra:=[profile?]
	>=dev-haskell/exceptions-0.6:=[profile?] <dev-haskell/exceptions-0.11:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/old-time:=[profile?]
	dev-haskell/utf8-string:=[profile?]
	>=dev-lang/ghc-7.4.1:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
"
