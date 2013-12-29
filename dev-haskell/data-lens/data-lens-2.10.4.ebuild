# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# ebuild generated by hackport 0.3.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Haskell 98 Lenses"
HOMEPAGE="http://github.com/roconnor/data-lens/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+derivedatatypeable"

RDEPEND=">=dev-haskell/comonad-4.0:=[profile?] <dev-haskell/comonad-4.1:=[profile?]
	>=dev-haskell/semigroupoids-4.0:=[profile?] <dev-haskell/semigroupoids-4.1:=[profile?]
	>=dev-haskell/transformers-0.2.0:=[profile?] <dev-haskell/transformers-0.4:=[profile?]
	>=dev-lang/ghc-6.12.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8.0.2
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag derivedatatypeable derivedatatypeable)
}
