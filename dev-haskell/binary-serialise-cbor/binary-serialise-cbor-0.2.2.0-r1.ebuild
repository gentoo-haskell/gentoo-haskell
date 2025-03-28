# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999

CABAL_HACKAGE_REVISION=2

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Yet Another Binary Serialisation Library (compatibility shim)"
HOMEPAGE="https://hackage.haskell.org/package/binary-serialise-cbor"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/cborg-0.2:=[profile?] <dev-haskell/cborg-0.3:=[profile?]
	>=dev-haskell/serialise-0.2:=[profile?] <dev-haskell/serialise-0.3:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
"
