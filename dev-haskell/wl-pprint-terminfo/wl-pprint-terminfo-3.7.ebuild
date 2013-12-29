# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# ebuild generated by hackport 0.3.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A color pretty printer with terminfo support"
HOMEPAGE="http://github.com/ekmett/wl-pprint-terminfo/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+cursed"

RDEPEND=">=dev-haskell/nats-0.1:=[profile?] <dev-haskell/nats-1:=[profile?]
	>=dev-haskell/semigroups-0.9:=[profile?] <dev-haskell/semigroups-1:=[profile?]
	>=dev-haskell/terminfo-0.3.2:=[profile?] <dev-haskell/terminfo-0.4:=[profile?]
	>=dev-haskell/text-0.11:=[profile?] <dev-haskell/text-1.2:=[profile?]
	>=dev-haskell/transformers-0.2:=[profile?] <dev-haskell/transformers-0.4:=[profile?]
	>=dev-haskell/wl-pprint-extras-3.4:=[profile?] <dev-haskell/wl-pprint-extras-4:=[profile?]
	>=dev-lang/ghc-7.0.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10.0.0
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag cursed cursed)
}
