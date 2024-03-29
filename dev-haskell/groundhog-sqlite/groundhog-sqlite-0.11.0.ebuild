# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Sqlite3 backend for the groundhog library"
HOMEPAGE="https://hackage.haskell.org/package/groundhog-sqlite"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-haskell/direct-sqlite-2.3.5:=[profile?]
	>=dev-haskell/groundhog-0.11.0:=[profile?] <dev-haskell/groundhog-0.12:=[profile?]
	>=dev-haskell/monad-control-0.3:=[profile?] <dev-haskell/monad-control-1.1:=[profile?]
	>=dev-haskell/resource-pool-0.2.1:=[profile?]
	>=dev-haskell/resourcet-1.1.2:=[profile?]
	>=dev-haskell/text-0.8:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
"
