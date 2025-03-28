# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.5.1.9999

CABAL_HACKAGE_REVISION=2

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Interface for versioning file stores"
HOMEPAGE="https://hackage.haskell.org/package/filestore"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+maxcount"

RESTRICT=test # requires mercurial to run the tests

CABAL_CHDEPS=(
	'Diff >= 0.4 && < 0.6' 'Diff >=0.4'
)

RDEPEND="
	>=dev-haskell/diff-0.4:=[profile?]
	>=dev-haskell/old-locale-1.0:=[profile?] <dev-haskell/old-locale-1.1:=[profile?]
	>=dev-haskell/parsec-2:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-haskell/split-0.1:=[profile?] <dev-haskell/split-0.3:=[profile?]
	>=dev-haskell/utf8-string-0.3:=[profile?] <dev-haskell/utf8-string-1.1:=[profile?]
	>=dev-haskell/xml-1.3:=[profile?] <dev-haskell/xml-1.4:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? (
		>=dev-haskell/hunit-1.2 <dev-haskell/hunit-1.7
	)
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag maxcount maxcount)
}
