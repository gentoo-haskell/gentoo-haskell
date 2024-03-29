# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.7.9999
#hackport: flags: -use-pkg-config

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="low-level binding to libpq"
HOMEPAGE="https://github.com/haskellari/postgresql-libpq"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-db/postgresql-7
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
"

src_prepare() {
	default

	cabal_chdeps \
		'base        >=4.3     && <4.15' 'base        >=4.3' \
		'Cabal  >=1.10 && <3.3' 'Cabal  >=1.10'
}

src_configure() {
	haskell-cabal_src_configure \
		--flag=-use-pkg-config
}
