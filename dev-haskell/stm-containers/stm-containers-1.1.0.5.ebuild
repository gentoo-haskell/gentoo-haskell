# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour" # test-suite"
inherit haskell-cabal

DESCRIPTION="Containers for STM"
HOMEPAGE="https://github.com/nikita-volkov/stm-containers"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT=test

RDEPEND=">=dev-haskell/deferred-folds-0.9:=[profile?] <dev-haskell/deferred-folds-0.10:=[profile?]
	>=dev-haskell/focus-1.0.1.4:=[profile?] <dev-haskell/focus-1.1:=[profile?]
	<dev-haskell/hashable-2:=[profile?]
	>=dev-haskell/list-t-1.0.1:=[profile?] <dev-haskell/list-t-1.1:=[profile?]
	>=dev-haskell/stm-hamt-1.2:=[profile?] <dev-haskell/stm-hamt-1.3:=[profile?]
	>=dev-lang/ghc-8.0.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.24.0.0"
# 	test? ( >=dev-haskell/foldl-1.4 <dev-haskell/foldl-2
# 		>=dev-haskell/free-4.6 <dev-haskell/free-6
# 		>=dev-haskell/htf-0.13 <dev-haskell/htf-0.14
# 		>=dev-haskell/quickcheck-2.7 <dev-haskell/quickcheck-3
# 		>=dev-haskell/quickcheck-text-0.1.2.1 <dev-haskell/quickcheck-text-0.2
# 		>=dev-haskell/rerebase-1 <dev-haskell/rerebase-2 )
# "
