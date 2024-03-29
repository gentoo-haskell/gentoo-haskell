# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.5.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="types and parser for email messages (including MIME)"
HOMEPAGE="https://github.com/purebred-mua/purebred-email"

LICENSE="AGPL-3+"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="demos"

RDEPEND=">=dev-haskell/attoparsec-0.13[profile?] <dev-haskell/attoparsec-0.15[profile?]
	>=dev-haskell/base64-bytestring-1[profile?] <dev-haskell/base64-bytestring-2[profile?]
	>=dev-haskell/case-insensitive-1.2[profile?] <dev-haskell/case-insensitive-1.3[profile?]
	>=dev-haskell/concise-0.1.0.1[profile?] <dev-haskell/concise-1[profile?]
	>=dev-haskell/lens-4[profile?] <dev-haskell/lens-6[profile?]
	>=dev-haskell/random-1.2.0[profile?]
	>=dev-haskell/semigroupoids-5[profile?] <dev-haskell/semigroupoids-7[profile?]
	>=dev-haskell/stringsearch-0.3[profile?]
	>=dev-haskell/text-1.2[profile?]
	>=dev-lang/ghc-9.0.2
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? ( dev-haskell/hedgehog
		dev-haskell/quickcheck-instances
		dev-haskell/tasty
		dev-haskell/tasty-golden
		dev-haskell/tasty-hedgehog
		dev-haskell/tasty-hunit
		dev-haskell/tasty-quickcheck )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag demos demos)
}
