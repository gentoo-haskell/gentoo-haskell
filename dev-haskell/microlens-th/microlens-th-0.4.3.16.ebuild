# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.5.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Automatic generation of record lenses for microlens"
HOMEPAGE="https://github.com/stevenfontanella/microlens"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/microlens-0.4.0:=[profile?] <dev-haskell/microlens-0.5:=[profile?]
	>=dev-haskell/th-abstraction-0.4.1:=[profile?] <dev-haskell/th-abstraction-0.8:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? ( dev-haskell/tagged )
"
