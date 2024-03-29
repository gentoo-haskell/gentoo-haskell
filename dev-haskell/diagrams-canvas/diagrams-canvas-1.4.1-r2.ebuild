# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="HTML5 canvas backend for diagrams drawing EDSL"
HOMEPAGE="http://projects.haskell.org/diagrams/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-haskell/blank-canvas-0.5:=[profile?]
	>=dev-haskell/cmdargs-0.6:=[profile?] <dev-haskell/cmdargs-0.11:=[profile?]
	>=dev-haskell/data-default-class-0.0.1:=[profile?] <dev-haskell/data-default-class-0.2:=[profile?]
	>=dev-haskell/diagrams-core-1.3:=[profile?]
	>=dev-haskell/diagrams-lib-1.3:=[profile?] <dev-haskell/diagrams-lib-1.5:=[profile?]
	>=dev-haskell/lens-4.0:=[profile?]
	>=dev-haskell/mtl-2.0:=[profile?] <dev-haskell/mtl-3.0:=[profile?]
	>=dev-haskell/numinstances-1.0:=[profile?] <dev-haskell/numinstances-1.5:=[profile?]
	>=dev-haskell/optparse-applicative-0.13:=[profile?]
	>=dev-haskell/statestack-0.2:=[profile?]
	>=dev-haskell/text-1.0:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-lang/ghc-7.6.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.16.0
"

src_prepare() {
	default

	cabal_chdeps \
		'optparse-applicative >= 0.13 && < 0.15' 'optparse-applicative >= 0.13' \
		'base >= 4.6 && < 4.12' 'base >= 4.6' \
		'lens >= 4.0 && < 4.17' 'lens >= 4.0' \
		'containers >= 0.3 && < 0.6' 'containers >= 0.3' \
		'blank-canvas >= 0.5 && < 0.7' 'blank-canvas >= 0.5' \
		'statestack >= 0.2 && <0.3' 'statestack >= 0.2' \
		'diagrams-core >= 1.3 && < 1.5' 'diagrams-core >= 1.3'
}
