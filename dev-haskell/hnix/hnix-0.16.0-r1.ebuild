# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.0.0.9999
#hackport: flags: -profiling

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Haskell implementation of the Nix language"
HOMEPAGE="https://github.com/haskell-nix/hnix#readme"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="executable +optimize"

CABAL_CHDEPS=(
	'optparse-applicative >= 0.14.3 && < 0.17' 'optparse-applicative >= 0.14.3'
	'relude >= 1.0.0 && < 1.1.0' 'relude >= 1.0.0'
	'aeson >= 1.4.2 && < 1.6 || >= 2.0 && < 2.1' 'aeson >= 2.0'
	'logict >= 0.6.0 && < 0.7 || >= 0.7.0.2 && < 0.8' 'logict >= 0.7.0.2'
)

PATCHES=(
	"${FILESDIR}/${PN}-0.14.0.2-add-executable-flag.patch"
)

RDEPEND="
	>=dev-haskell/aeson-2.0:=[profile?]
	>=dev-haskell/base16-bytestring-0.1.1:=[profile?] <dev-haskell/base16-bytestring-1.1:=[profile?]
	>=dev-haskell/comonad-5.0.4:=[profile?] <dev-haskell/comonad-5.1:=[profile?]
	dev-haskell/cryptonite:=[profile?]
	>=dev-haskell/data-fix-0.3.0:=[profile?] <dev-haskell/data-fix-0.4:=[profile?]
	>=dev-haskell/deriving-compat-0.3:=[profile?] <dev-haskell/deriving-compat-0.7:=[profile?]
	>=dev-haskell/free-5.1:=[profile?] <dev-haskell/free-5.2:=[profile?]
	>=dev-haskell/gitrev-1.1.0:=[profile?] <dev-haskell/gitrev-1.4:=[profile?]
	>=dev-haskell/hashable-1.2.5:=[profile?] <dev-haskell/hashable-1.5:=[profile?]
	>=dev-haskell/hashing-0.1.0:=[profile?] <dev-haskell/hashing-0.2:=[profile?]
	>=dev-haskell/hnix-store-core-0.5.0:=[profile?] <dev-haskell/hnix-store-core-0.6:=[profile?]
	>=dev-haskell/hnix-store-remote-0.5.0:=[profile?] <dev-haskell/hnix-store-remote-0.6:=[profile?]
	>=dev-haskell/http-client-0.6.4:=[profile?] <dev-haskell/http-client-0.8:=[profile?]
	>=dev-haskell/http-client-tls-0.3.5:=[profile?] <dev-haskell/http-client-tls-0.4:=[profile?]
	>=dev-haskell/http-types-0.12.2:=[profile?] <dev-haskell/http-types-0.13:=[profile?]
	>=dev-haskell/lens-family-1.2.2:=[profile?] <dev-haskell/lens-family-2.2:=[profile?]
	>=dev-haskell/lens-family-core-1.2.2:=[profile?] <dev-haskell/lens-family-core-2.2:=[profile?]
	>=dev-haskell/lens-family-th-0.5.0:=[profile?] <dev-haskell/lens-family-th-0.6:=[profile?]
	>=dev-haskell/logict-0.7.0.2:=[profile?]
	>=dev-haskell/megaparsec-7.0:=[profile?] <dev-haskell/megaparsec-9.3:=[profile?]
	>=dev-haskell/monad-control-1.0.2:=[profile?] <dev-haskell/monad-control-1.1:=[profile?]
	>=dev-haskell/monadlist-0.0.2:=[profile?] <dev-haskell/monadlist-0.1:=[profile?]
	>=dev-haskell/neat-interpolation-0.4:=[profile?] <dev-haskell/neat-interpolation-0.6:=[profile?]
	>=dev-haskell/optparse-applicative-0.14.3:=[profile?]
	>=dev-haskell/parser-combinators-1.0.1:=[profile?] <dev-haskell/parser-combinators-1.4:=[profile?]
	>=dev-haskell/pretty-show-1.9.5:=[profile?] <dev-haskell/pretty-show-1.11:=[profile?]
	>=dev-haskell/prettyprinter-1.7.0:=[profile?] <dev-haskell/prettyprinter-1.8:=[profile?]
	|| ( dev-lang/ghc ( >=dev-haskell/process-1.6.3[profile?] <dev-haskell/process-1.7[profile?] ) )
	>=dev-haskell/ref-tf-0.5:=[profile?] <dev-haskell/ref-tf-0.6:=[profile?]
	>=dev-haskell/regex-tdfa-1.2.3:=[profile?] <dev-haskell/regex-tdfa-1.4:=[profile?]
	>=dev-haskell/relude-1.0.0:=[profile?]
	>=dev-haskell/scientific-0.3.6:=[profile?] <dev-haskell/scientific-0.4:=[profile?]
	>=dev-haskell/semialign-1.2:=[profile?] <dev-haskell/semialign-1.3:=[profile?]
	>=dev-haskell/serialise-0.2.1:=[profile?] <dev-haskell/serialise-0.3:=[profile?]
	>=dev-haskell/some-1.0.1:=[profile?] <dev-haskell/some-1.1:=[profile?]
	>=dev-haskell/split-0.2.3:=[profile?] <dev-haskell/split-0.3:=[profile?]
	>=dev-haskell/syb-0.7:=[profile?] <dev-haskell/syb-0.8:=[profile?]
	>=dev-haskell/th-lift-instances-0.1:=[profile?] <dev-haskell/th-lift-instances-0.2:=[profile?]
	>=dev-haskell/these-1.0.1:=[profile?] <dev-haskell/these-1.2:=[profile?]
	>=dev-haskell/transformers-base-0.4.5:=[profile?] <dev-haskell/transformers-base-0.5:=[profile?]
	>=dev-haskell/unix-compat-0.4.3:=[profile?] <dev-haskell/unix-compat-0.6:=[profile?]
	>=dev-haskell/unordered-containers-0.2.9:=[profile?] <dev-haskell/unordered-containers-0.3:=[profile?]
	>=dev-haskell/vector-0.12.0:=[profile?] <dev-haskell/vector-0.13:=[profile?]
	>=dev-haskell/xml-1.3.14:=[profile?] <dev-haskell/xml-1.4:=[profile?]
	>=dev-lang/ghc-8.10.1:=[profile?]
	executable? (
		>=dev-haskell/haskeline-0.8.0.0:=[profile?] <dev-haskell/haskeline-0.9:=[profile?]
		>=dev-haskell/repline-0.4.0.0:=[profile?] <dev-haskell/repline-0.5:=[profile?]
	)
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.2.0.0
	test? (
		dev-haskell/diff
		dev-haskell/glob
		dev-haskell/hedgehog
		dev-haskell/tasty
		dev-haskell/tasty-hedgehog
		dev-haskell/tasty-hunit
		dev-haskell/tasty-th
	)
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag executable executable) \
		$(cabal_flag optimize optimize) \
		--flag=-profiling
}
