# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999

CABAL_HACKAGE_REVISION=1

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Gdk 3.x bindings (compatibility layer)"
HOMEPAGE="https://github.com/haskell-gi/haskell-gi"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64"

GHC_BOOTSTRAP_PACKAGES=(
	haskell-gi
	gi-gdk3
	)

RDEPEND=">=dev-haskell/gi-gdk3-3.0.30:=[profile?] <dev-haskell/gi-gdk3-3.1:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0 <dev-haskell/cabal-4
	>=dev-haskell/haskell-gi-0.26.14 <dev-haskell/haskell-gi-0.27
"
