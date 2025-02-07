# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999
#hackport: flags: -enable-psql-test

# These tests most likely spin up an instance of postgresql, and are not
# appropriate for gentoo's sandbox
CABAL_FEATURES="lib profile haddock hoogle hscolour" # test-suite"
inherit haskell-cabal

DESCRIPTION="Manage PostgreSQL servers with gargoyle"
HOMEPAGE="https://hackage.haskell.org/package/gargoyle-postgresql"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="executables"

RESTRICT=test

PATCHES=( "${FILESDIR}/${PN}-0.2.0.1-add-executables-flag.patch" )

RDEPEND=">=dev-haskell/gargoyle-0.1.1.0:=[profile?] <dev-haskell/gargoyle-0.2:=[profile?]
	>=dev-haskell/posix-escape-0.1:=[profile?] <dev-haskell/posix-escape-0.2:=[profile?]
	>=dev-haskell/stringsearch-0.3:=[profile?] <dev-haskell/stringsearch-0.4:=[profile?]
	>=dev-haskell/text-1.2:=[profile?] <dev-haskell/text-2.2:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag executables) \
		--flag=-enable-psql-test
}
