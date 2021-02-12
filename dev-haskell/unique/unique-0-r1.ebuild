# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.3.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Fully concurrent unique identifiers"
HOMEPAGE="https://github.com/ekmett/unique/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/hashable-1.1:=[profile?] <dev-haskell/hashable-1.4:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
"

src_prepare() {
	default

	#as per https://hackage.haskell.org/package/unique-0/revisions/
	cabal_chdeps \
		'ghc-prim >= 0.2 && < 0.5' 'ghc-prim >= 0.2' \
		'hashable >= 1.1 && < 1.3' 'hashable >= 1.1 && < 1.4'
}
