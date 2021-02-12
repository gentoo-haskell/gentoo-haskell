# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

MY_PN="STMonadTrans"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A monad transformer version of the ST monad"
HOMEPAGE="https://hackage.haskell.org/package/STMonadTrans"
SRC_URI="https://hackage.haskell.org/package/${MY_P}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/fail:=[profile?]
	dev-haskell/mtl:=[profile?]
	>=dev-lang/ghc-7.6.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.16.0
	test? ( >=dev-haskell/tasty-0.11.0.4 <dev-haskell/tasty-1.3
		>=dev-haskell/tasty-hunit-0.9.2 <dev-haskell/tasty-hunit-0.11
		>=dev-haskell/tasty-quickcheck-0.8.4 <dev-haskell/tasty-quickcheck-0.11
		>=dev-haskell/transformers-0.4 <dev-haskell/transformers-0.6 )
"

S="${WORKDIR}/${MY_P}"
