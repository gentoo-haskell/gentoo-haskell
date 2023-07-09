# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0
#hackport: flags: tools:executable

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Password strength estimation based on zxcvbn"
HOMEPAGE="https://github.com/sthenauth/zxcvbn-hs"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="executable"

RDEPEND=">=dev-haskell/aeson-1.3:=[profile?] <dev-haskell/aeson-2.2:=[profile?]
	>=dev-haskell/attoparsec-0.13:=[profile?] <dev-haskell/attoparsec-0.15:=[profile?]
	>=dev-haskell/base64-bytestring-1.0:=[profile?] <dev-haskell/base64-bytestring-1.3:=[profile?]
	>=dev-haskell/binary-instances-1:=[profile?] <dev-haskell/binary-instances-2.0:=[profile?]
	>=dev-haskell/fgl-5.7:=[profile?] <dev-haskell/fgl-5.9:=[profile?]
	>=dev-haskell/lens-4.17:=[profile?] <dev-haskell/lens-6:=[profile?]
	>=dev-haskell/math-functions-0.3:=[profile?] <dev-haskell/math-functions-0.4:=[profile?]
	>=dev-haskell/text-1.2:=[profile?] <dev-haskell/text-2.1:=[profile?]
	>=dev-haskell/unordered-containers-0.2:=[profile?] <dev-haskell/unordered-containers-0.3:=[profile?]
	>=dev-haskell/vector-0.12:=[profile?] <dev-haskell/vector-0.14:=[profile?]
	>=dev-haskell/zlib-0.6:=[profile?] <dev-haskell/zlib-0.7:=[profile?]
	>=dev-lang/ghc-8.8.1:=
	executable? ( >=dev-haskell/optparse-applicative-0.14:=[profile?] <dev-haskell/optparse-applicative-0.18:=[profile?]
			>=dev-haskell/pipes-4.3:=[profile?] <dev-haskell/pipes-4.4:=[profile?]
			>=dev-haskell/pipes-safe-2.3:=[profile?] <dev-haskell/pipes-safe-2.4:=[profile?]
			>=dev-haskell/pipes-text-0.0:=[profile?] <dev-haskell/pipes-text-1.1:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.0.0.0
	test? ( >=dev-haskell/hedgehog-0.6 <dev-haskell/hedgehog-1.3
		>=dev-haskell/tasty-1.1 <dev-haskell/tasty-1.5
		>=dev-haskell/tasty-hedgehog-0.2 <dev-haskell/tasty-hedgehog-2
		>=dev-haskell/tasty-hunit-0.10 <dev-haskell/tasty-hunit-0.11 )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag executable tools)
}
