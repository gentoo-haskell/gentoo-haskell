# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.7.9999
#hackport: flags: +system-erf,+system-expm1

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Collection of tools for numeric computations"
HOMEPAGE="https://github.com/bos/math-functions"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/data-default-class-0.1.2.0:=[profile?]
	dev-haskell/primitive:=[profile?]
	>=dev-haskell/vector-0.11:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( dev-haskell/erf
		>=dev-haskell/quickcheck-2.7
		>=dev-haskell/tasty-1.2
		>=dev-haskell/tasty-hunit-0.10
		>=dev-haskell/tasty-quickcheck-0.10
		dev-haskell/vector-th-unbox )
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=system-erf \
		--flag=system-expm1
}
