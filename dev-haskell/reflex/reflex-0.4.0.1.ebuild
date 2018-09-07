# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.6

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Higher-order Functional Reactive Programming"
HOMEPAGE="https://github.com/reflex-frp/reflex"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/dependent-map-0.2:=[profile?] <dev-haskell/dependent-map-0.3:=[profile?]
	>=dev-haskell/dependent-sum-0.3:=[profile?] <dev-haskell/dependent-sum-0.5:=[profile?]
	>=dev-haskell/exception-transformers-0.4:=[profile?] <dev-haskell/exception-transformers-0.5:=[profile?]
	>=dev-haskell/haskell-src-exts-1.16:=[profile?] <dev-haskell/haskell-src-exts-1.20:=[profile?]
	>=dev-haskell/haskell-src-meta-0.6:=[profile?] <dev-haskell/haskell-src-meta-0.9:=[profile?]
	>=dev-haskell/mtl-2.1:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/primitive-0.5:=[profile?] <dev-haskell/primitive-0.7:=[profile?]
	>=dev-haskell/ref-tf-0.4:=[profile?] <dev-haskell/ref-tf-0.5:=[profile?]
	>=dev-haskell/semigroups-0.16:=[profile?] <dev-haskell/semigroups-0.19:=[profile?]
	>=dev-haskell/syb-0.4.4:=[profile?] <dev-haskell/syb-0.8:=[profile?]
	>=dev-haskell/these-0.4:=[profile?] <dev-haskell/these-0.8:=[profile?]
	>=dev-haskell/transformers-compat-0.3:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( >=dev-haskell/memotrie-0.6 <dev-haskell/memotrie-0.7 )
"
