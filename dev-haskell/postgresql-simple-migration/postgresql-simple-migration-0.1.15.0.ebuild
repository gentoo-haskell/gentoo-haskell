# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.3

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="PostgreSQL Schema Migrations"
HOMEPAGE="https://github.com/ameingast/postgresql-simple-migration"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT=test #Seeking a postgres instance? `libpq: failed (FATAL:  role "portage" does not exist)`

RDEPEND=">=dev-haskell/base64-bytestring-1.0:=[profile?] <dev-haskell/base64-bytestring-1.1:=[profile?]
	>=dev-haskell/cryptohash-0.11:=[profile?] <dev-haskell/cryptohash-0.12:=[profile?]
	>=dev-haskell/postgresql-simple-0.4:=[profile?] <dev-haskell/postgresql-simple-0.7:=[profile?]
	>=dev-haskell/text-1.2:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-lang/ghc-7.6.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.16.0
	test? ( >=dev-haskell/hspec-2.2 <dev-haskell/hspec-2.8 )
"
