# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Monad transformer carrying an extra phantom type tag"
HOMEPAGE="https://github.com/ekmett/tagged-transformer"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/comonad-4:=[profile?] <dev-haskell/comonad-6:=[profile?]
	>=dev-haskell/contravariant-0.3:=[profile?] <dev-haskell/contravariant-2:=[profile?]
	>=dev-haskell/distributive-0.3:=[profile?] <dev-haskell/distributive-1:=[profile?]
	>=dev-haskell/reflection-1.1.6:=[profile?] <dev-haskell/reflection-3:=[profile?]
	>=dev-haskell/semigroupoids-4:=[profile?] <dev-haskell/semigroupoids-7:=[profile?]
	>=dev-haskell/tagged-0.4.4:=[profile?] <dev-haskell/tagged-1:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
"
