# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Rasterific backend for diagrams"
HOMEPAGE="https://projects.haskell.org/diagrams/"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-haskell/data-default-class-0.0:=[profile?] <dev-haskell/data-default-class-0.2:=[profile?]
	>=dev-haskell/diagrams-core-1.4:=[profile?] <dev-haskell/diagrams-core-1.6:=[profile?]
	>=dev-haskell/diagrams-lib-1.4:=[profile?] <dev-haskell/diagrams-lib-1.5:=[profile?]
	>=dev-haskell/file-embed-0.0:=[profile?] <dev-haskell/file-embed-0.1:=[profile?]
	>=dev-haskell/fontyfruity-0.5:=[profile?] <dev-haskell/fontyfruity-0.6:=[profile?]
	>=dev-haskell/hashable-1.1:=[profile?] <dev-haskell/hashable-1.5:=[profile?]
	>=dev-haskell/juicypixels-3.1.5:=[profile?] <dev-haskell/juicypixels-3.4:=[profile?]
	>=dev-haskell/lens-4.0:=[profile?] <dev-haskell/lens-5.3:=[profile?]
	>=dev-haskell/optparse-applicative-0.13:=[profile?] <dev-haskell/optparse-applicative-0.19:=[profile?]
	>=dev-haskell/rasterific-0.7.4:=[profile?] <dev-haskell/rasterific-0.8:=[profile?]
	>=dev-lang/ghc-8.10.6:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.2.1.0
"
