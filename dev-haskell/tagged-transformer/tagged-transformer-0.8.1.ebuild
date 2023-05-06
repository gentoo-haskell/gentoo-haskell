# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.5.6

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Provides newtype wrappers for phantom types"
HOMEPAGE="https://github.com/ekmett/tagged-transformer"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-haskell/comonad-4:=[profile?] <dev-haskell/comonad-6:=[profile?]
	>=dev-haskell/contravariant-0.3:=[profile?] <dev-haskell/contravariant-2:=[profile?]
	>=dev-haskell/distributive-0.3:=[profile?] <dev-haskell/distributive-1:=[profile?]
	>=dev-haskell/exceptions-0.6:=[profile?] <dev-haskell/exceptions-1:=[profile?]
	>=dev-haskell/mtl-2.0.1:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/reflection-1.1.6:=[profile?] <dev-haskell/reflection-3:=[profile?]
	>=dev-haskell/semigroupoids-4:=[profile?] <dev-haskell/semigroupoids-6:=[profile?]
	>=dev-haskell/tagged-0.4.4:=[profile?] <dev-haskell/tagged-1:=[profile?]
	>=dev-lang/ghc-7.4.1:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
"
