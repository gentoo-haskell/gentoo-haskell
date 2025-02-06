# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.5.1.9999

CABAL_HACKAGE_REVISION=1

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Reading, writing and manipulating \".tar\" archive files"
HOMEPAGE="https://hackage.haskell.org/package/tar"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

RDEPEND=">=dev-haskell/os-string-2.0:=[profile?] <dev-haskell/os-string-2.1:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? ( dev-haskell/file-embed
		>=dev-haskell/quickcheck-2 <dev-haskell/quickcheck-3
		>=dev-haskell/tasty-0.10 <dev-haskell/tasty-1.6
		>=dev-haskell/tasty-quickcheck-0.8 <dev-haskell/tasty-quickcheck-1
		<dev-haskell/temporary-1.4 )
"
