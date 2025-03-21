# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999
#hackport: flags: -static

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Cryptol: The Language of Cryptography"
HOMEPAGE="https://www.cryptol.net/"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ffi +relocatable"

CABAL_CHDEPS=(
	'base-compat       >= 0.6 && < 0.13' 'base-compat >= 0.6'
	'sbv               >= 9.1 && < 10.11' 'sbv >= 9.1'
	'what4             >= 1.4 && < 1.7' 'what4 >= 1.4'
)

RDEPEND="dev-haskell/ansi-terminal:=[profile?]
	>=dev-haskell/arithmoi-0.12:=[profile?]
	>=dev-haskell/async-2.2:=[profile?] <dev-haskell/async-2.3:=[profile?]
	>=dev-haskell/base-compat-0.6:=[profile?]
	dev-haskell/blaze-html:=[profile?]
	>=dev-haskell/bv-sized-1.0:=[profile?] <dev-haskell/bv-sized-1.1:=[profile?]
	dev-haskell/criterion-measurement:=[profile?]
	>=dev-haskell/cryptohash-sha1-0.11:=[profile?] <dev-haskell/cryptohash-sha1-0.12:=[profile?]
	dev-haskell/extra:=[profile?]
	>=dev-haskell/file-embed-0.0.16:=[profile?]
	>=dev-haskell/gitrev-1.0:=[profile?]
	>=dev-haskell/graphscc-1.0.4:=[profile?]
	>=dev-haskell/haskeline-0.7:=[profile?] <dev-haskell/haskeline-0.9:=[profile?]
	dev-haskell/language-c99:=[profile?]
	dev-haskell/language-c99-simple:=[profile?]
	>=dev-haskell/libbf-0.6:=[profile?] <dev-haskell/libbf-0.7:=[profile?]
	>=dev-haskell/memotrie-0.6:=[profile?] <dev-haskell/memotrie-0.7:=[profile?]
	>=dev-haskell/monad-control-1.0:=[profile?]
	>=dev-haskell/monadlib-3.7.2:=[profile?]
	dev-haskell/optparse-applicative:=[profile?]
	>=dev-haskell/panic-0.3:=[profile?]
	>=dev-haskell/parameterized-utils-2.0.2:=[profile?]
	dev-haskell/pretty-show:=[profile?]
	>=dev-haskell/prettyprinter-1.7.0:=[profile?]
	>=dev-haskell/sbv-9.1:=[profile?]
	>=dev-haskell/simple-smt-0.9.7:=[profile?]
	dev-haskell/strict:=[profile?]
	dev-haskell/temporary:=[profile?]
	>=dev-haskell/text-1.1:=[profile?]
	>=dev-haskell/tf-random-0.5:=[profile?]
	>=dev-haskell/transformers-base-0.4:=[profile?]
	dev-haskell/vector:=[profile?]
	>=dev-haskell/what4-1.4:=[profile?]
	>=dev-lang/ghc-9.0.2:=
	ffi? ( dev-haskell/hgmp:=[profile?]
		>=dev-haskell/libffi-0.2:=[profile?] )
	sci-mathematics/z3
"
	# sci-mathematics/z3: runtime-only depend, used for :prove
DEPEND="${RDEPEND}
	dev-haskell/alex
	>=dev-haskell/cabal-3.4.1.0
	dev-haskell/happy
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag ffi ffi) \
		$(cabal_flag relocatable relocatable) \
		--flag=-static
}
