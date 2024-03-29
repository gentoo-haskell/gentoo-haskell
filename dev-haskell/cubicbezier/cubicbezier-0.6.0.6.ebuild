# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.1

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Efficient manipulating of 2D cubic bezier curves"
HOMEPAGE="https://hackage.haskell.org/package/cubicbezier"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND=">=dev-haskell/fast-math-1.0.0:=[profile?]
	>=dev-haskell/integration-0.1.1:=[profile?]
	>=dev-haskell/matrices-0.5.0:=[profile?]
	>=dev-haskell/microlens-0.1.2:=[profile?]
	>=dev-haskell/microlens-mtl-0.1.2:=[profile?]
	>=dev-haskell/microlens-th-0.1.2:=[profile?]
	>=dev-haskell/mtl-2.1.1:=[profile?]
	>=dev-haskell/semigroups-0.16:=[profile?]
	>=dev-haskell/vector-0.10:=[profile?]
	>=dev-haskell/vector-space-0.10.4:=[profile?]
	>=dev-lang/ghc-7.10.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.22.2.0
	test? ( >=dev-haskell/parsec-3.0
		>=dev-haskell/tasty-0.8
		>=dev-haskell/tasty-hunit-0.9 )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag debug debug)
}
