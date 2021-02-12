# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.7.9999
#hackport: flags: embed_linear:embed-linear

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

MY_PN="Rasterific"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A pure haskell drawing engine"
HOMEPAGE="https://hackage.haskell.org/package/Rasterific"
SRC_URI="https://hackage.haskell.org/package/${MY_P}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+embed-linear"

RDEPEND=">=dev-haskell/dlist-0.6:=[profile?]
	>=dev-haskell/fail-4.9:=[profile?] <dev-haskell/fail-4.10:=[profile?]
	>=dev-haskell/fontyfruity-0.5.3.4:=[profile?] <dev-haskell/fontyfruity-0.6:=[profile?]
	>=dev-haskell/free-4.7:=[profile?]
	>=dev-haskell/juicypixels-3.3.2:=[profile?]
	>=dev-haskell/mtl-1.9:=[profile?]
	>=dev-haskell/primitive-0.5:=[profile?]
	>=dev-haskell/semigroups-0.18:=[profile?] <dev-haskell/semigroups-0.19:=[profile?]
	>=dev-haskell/vector-0.9:=[profile?]
	>=dev-haskell/vector-algorithms-0.3:=[profile?]
	>=dev-lang/ghc-7.10.1:=
	!embed-linear? ( >=dev-haskell/linear-1.3:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.22.2.0
"

S="${WORKDIR}/${MY_P}"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag embed-linear embed_linear)
}
