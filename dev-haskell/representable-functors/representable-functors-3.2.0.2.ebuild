# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# ebuild generated by hackport 0.3.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Representable functors"
HOMEPAGE="http://github.com/ekmett/representable-functors/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/comonad-3:=[profile?] <dev-haskell/comonad-5:=[profile?]
	>=dev-haskell/comonad-transformers-3:=[profile?] <dev-haskell/comonad-transformers-5:=[profile?]
	>=dev-haskell/comonads-fd-3:=[profile?] <dev-haskell/comonads-fd-5:=[profile?]
	>=dev-haskell/contravariant-0.4.1:=[profile?] <dev-haskell/contravariant-1:=[profile?]
	>=dev-haskell/distributive-0.2.2:=[profile?] <dev-haskell/distributive-1:=[profile?]
	>=dev-haskell/free-3:=[profile?] <dev-haskell/free-5:=[profile?]
	>=dev-haskell/keys-3:=[profile?] <dev-haskell/keys-4:=[profile?]
	>=dev-haskell/mtl-2.0.1.0:=[profile?] <dev-haskell/mtl-2.2:=[profile?]
	>=dev-haskell/semigroupoids-3:=[profile?] <dev-haskell/semigroupoids-5:=[profile?]
	>=dev-haskell/semigroups-0.8.3.1:=[profile?] <dev-haskell/semigroups-1:=[profile?]
	>=dev-haskell/transformers-0.2:=[profile?] <dev-haskell/transformers-0.4:=[profile?]
	>=dev-lang/ghc-7.0.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10.0.0
"

src_prepare() {
	cabal_chdeps \
		'comonad              >= 3       && < 4' 'comonad              >= 3       && < 5' \
		'comonad-transformers >= 3       && < 4' 'comonad-transformers >= 3       && < 5' \
		'comonads-fd          >= 3       && < 4' 'comonads-fd          >= 3       && < 5' \
		'free                 >= 3       && < 4' 'free                 >= 3       && < 5' \
		'semigroupoids        >= 3       && < 4' 'semigroupoids        >= 3       && < 5'
}
