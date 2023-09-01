# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999

CABAL_HACKAGE_REVISION=7

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Authentication combinators for servant"
HOMEPAGE="https://github.com/haskell-servant/servant/tree/master/servant-auth#readme"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/aeson-1.3.1.1:=[profile?] <dev-haskell/aeson-3:=[profile?]
	>=dev-haskell/jose-0.10:=[profile?] <dev-haskell/jose-0.11:=[profile?]
	>=dev-haskell/lens-4.16.1:=[profile?] <dev-haskell/lens-5.3:=[profile?]
	>=dev-haskell/servant-0.15:=[profile?] <dev-haskell/servant-0.21:=[profile?]
	>=dev-haskell/text-1.2.3.0:=[profile?] <dev-haskell/text-2.1:=[profile?]
	>=dev-haskell/unordered-containers-0.2.9.0:=[profile?] <dev-haskell/unordered-containers-0.3:=[profile?]
	>=dev-lang/ghc-8.10.6:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.2.1.0
"
