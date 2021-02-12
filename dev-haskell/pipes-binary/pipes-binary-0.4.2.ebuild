# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.1

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Encode and decode binary streams using the pipes and binary libraries"
HOMEPAGE="https://github.com/k0001/pipes-binary"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/pipes-4.0:=[profile?]
	>=dev-haskell/pipes-bytestring-2.0:=[profile?]
	>=dev-haskell/pipes-parse-3.0:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( >=dev-haskell/lens-family-core-1.0
		>=dev-haskell/smallcheck-1.0
		>=dev-haskell/tasty-0.8
		>=dev-haskell/tasty-hunit-0.8
		>=dev-haskell/tasty-smallcheck-0.2 )
"
