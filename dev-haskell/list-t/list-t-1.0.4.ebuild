# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.1

CABAL_FEATURES="lib profile haddock hoogle hscolour" # test-suite deps need bumping (htf)
inherit haskell-cabal

DESCRIPTION="ListT done right"
HOMEPAGE="https://github.com/nikita-volkov/list-t"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT=test

RDEPEND=">=dev-haskell/foldl-1:=[profile?] <dev-haskell/foldl-2:=[profile?]
	>=dev-haskell/mmorph-1:=[profile?] <dev-haskell/mmorph-2:=[profile?]
	>=dev-haskell/monad-control-0.3:=[profile?] <dev-haskell/monad-control-2:=[profile?]
	>=dev-haskell/mtl-2:=[profile?] <dev-haskell/mtl-3:=[profile?]
	>=dev-haskell/transformers-base-0.4:=[profile?] <dev-haskell/transformers-base-0.5:=[profile?]
	>=dev-lang/ghc-8.0.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.24.0.0
"   #	test? ( dev-haskell/base-prelude
	#	>=dev-haskell/htf-0.13 <dev-haskell/htf-0.14
	#	<dev-haskell/mtl-prelude-3 )
