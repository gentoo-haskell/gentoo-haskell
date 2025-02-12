# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999

CABAL_HACKAGE_REVISION=1

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Streaming, parsers, arrays, serialization and more"
HOMEPAGE="https://streamly.composewell.com"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="debug dev folds has-llvm limit-build-mem +opt unfolds unliftio"

CABAL_CHDEPS=( 'ghc-prim          >= 0.5.3 && < 0.12' 'ghc-prim          >= 0.5.3 && < 0.14'
			'base              >= 4.12  && < 4.21' 'base              >= 4.12  && < 4.22'
			'template-haskell  >= 2.14  && < 2.22' 'template-haskell  >= 2.14  && < 2.24'
			)

RDEPEND=">=dev-haskell/fusion-plugin-types-0.1:=[profile?] <dev-haskell/fusion-plugin-types-0.2:=[profile?]
	>=dev-haskell/heaps-0.3:=[profile?] <dev-haskell/heaps-0.5:=[profile?]
	>=dev-lang/ghc-9.0.2:=
	!unliftio? ( >=dev-haskell/monad-control-1.0:=[profile?] <dev-haskell/monad-control-1.1:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag debug debug) \
		$(cabal_flag dev dev) \
		$(cabal_flag has-llvm has-llvm) \
		$(cabal_flag limit-build-mem limit-build-mem) \
		$(cabal_flag opt opt) \
		$(cabal_flag folds use-folds) \
		$(cabal_flag unfolds use-unfolds) \
		$(cabal_flag unliftio use-unliftio)
}
