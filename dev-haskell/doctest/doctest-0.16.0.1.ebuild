# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Test interactive Haskell examples"
HOMEPAGE="https://github.com/sol/doctest#readme"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Upstream has no intention fixing it:
# https://github.com/sol/doctest/pull/135
RESTRICT=test # module conflicts

RDEPEND=">=dev-haskell/base-compat-0.7.0:=[profile?]
	>=dev-haskell/code-page-0.1:=[profile?]
	>=dev-haskell/ghc-paths-0.1.0.9:=[profile?]
	>=dev-haskell/syb-0.3:=[profile?]
	>=dev-lang/ghc-7.0:=[profile?] <dev-lang/ghc-8.7:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( >=dev-haskell/hspec-1.5.1
		dev-haskell/hunit
		dev-haskell/mockery
		>=dev-haskell/quickcheck-2.11.3
		dev-haskell/setenv
		>=dev-haskell/silently-1.2.4
		>=dev-haskell/stringbuilder-0.4
		dev-haskell/with-location )
"
