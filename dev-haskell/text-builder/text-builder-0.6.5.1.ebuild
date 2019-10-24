# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.1

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="An efficient strict text builder"
HOMEPAGE="https://github.com/nikita-volkov/text-builder"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="<dev-haskell/base-prelude-2:=[profile?]
	>=dev-haskell/deferred-folds-0.9.9:=[profile?] <dev-haskell/deferred-folds-0.10:=[profile?]
	>=dev-haskell/semigroups-0.18:=[profile?] <dev-haskell/semigroups-0.20:=[profile?]
	>=dev-haskell/text-1:=[profile?] <dev-haskell/text-2:=[profile?]
	>=dev-lang/ghc-8.0.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.24.0.0
	test? ( >=dev-haskell/quickcheck-2.8.1 <dev-haskell/quickcheck-3
		>=dev-haskell/quickcheck-instances-0.3.11 <dev-haskell/quickcheck-instances-0.4
		<dev-haskell/rerebase-2
		>=dev-haskell/tasty-0.12 <dev-haskell/tasty-2
		>=dev-haskell/tasty-hunit-0.9 <dev-haskell/tasty-hunit-0.11
		>=dev-haskell/tasty-quickcheck-0.9 <dev-haskell/tasty-quickcheck-0.11 )
"
