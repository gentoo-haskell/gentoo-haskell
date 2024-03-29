# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.1

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="MySQL driver for HSQL"
HOMEPAGE="https://hackage.haskell.org/package/hsql-mysql"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-haskell/cabal:=[profile?]
	>=dev-haskell/hsql-1.8.2:=[profile?]
	>=dev-lang/ghc-7.4.1:=
	>=virtual/mysql-4.0
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
"
