# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.3

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Cairo backend for diagrams drawing EDSL"
HOMEPAGE="http://projects.haskell.org/diagrams"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/cairo-0.12.4:=[profile?] <dev-haskell/cairo-0.14:=[profile?]
	dev-haskell/colour:=[profile?]
	>=dev-haskell/data-default-class-0.0.1:=[profile?] <dev-haskell/data-default-class-0.2:=[profile?]
	>=dev-haskell/diagrams-core-1.3:=[profile?] <dev-haskell/diagrams-core-1.5:=[profile?]
	>=dev-haskell/diagrams-lib-1.3:=[profile?] <dev-haskell/diagrams-lib-1.5:=[profile?]
	>=dev-haskell/hashable-1.1:=[profile?] <dev-haskell/hashable-1.4:=[profile?]
	>=dev-haskell/juicypixels-3.1.3.2:=[profile?] <dev-haskell/juicypixels-3.4:=[profile?]
	>=dev-haskell/lens-3.8:=[profile?]
	>=dev-haskell/mtl-2.0:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/optparse-applicative-0.13:=[profile?] <dev-haskell/optparse-applicative-0.16:=[profile?]
	>=dev-haskell/pango-0.12.5:=[profile?] <dev-haskell/pango-0.14:=[profile?]
	>=dev-haskell/split-0.1.2:=[profile?] <dev-haskell/split-0.3:=[profile?]
	>=dev-haskell/statestack-0.2:=[profile?] <dev-haskell/statestack-0.4:=[profile?]
	>=dev-haskell/vector-0.10.0:=[profile?] <dev-haskell/vector-0.13:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
"

src_prepare() {
	default

	cabal_chdeps \
		'base >= 4.2 && < 4.14' 'base >= 4.2' \
		'containers >= 0.3 && < 0.7' 'containers >= 0.3' \
		'lens >= 3.8 && < 4.19' 'lens >= 3.8'
}
