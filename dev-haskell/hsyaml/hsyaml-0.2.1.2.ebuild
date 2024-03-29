# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999

CABAL_PN="HsYAML"

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Pure Haskell YAML 1.2 processor"
HOMEPAGE="https://github.com/haskell-hvr/HsYAML"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="exe"

RDEPEND=">=dev-haskell/parsec-3.1.13.0:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-haskell/text-1.2.3:=[profile?] <dev-haskell/text-2.2:=[profile?]
	>=dev-lang/ghc-8.10.6:=
	exe? ( >=dev-haskell/megaparsec-7.0:=[profile?] <dev-haskell/megaparsec-10:=[profile?]
		>=dev-haskell/microaeson-0.1:=[profile?] <dev-haskell/microaeson-0.2:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.2.1.0
	test? ( >=dev-haskell/quickcheck-2.14 <dev-haskell/quickcheck-2.15
		>=dev-haskell/tasty-1.4 <dev-haskell/tasty-1.6
		>=dev-haskell/tasty-quickcheck-0.10 <dev-haskell/tasty-quickcheck-0.11 )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag exe exe)
}
