# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="ExactPrint for GHC"
HOMEPAGE="https://hackage.haskell.org/package/ghc-exactprint"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	dev-haskell/data-default:=[profile?]
	>=dev-haskell/free-4.12:=[profile?]
	>=dev-haskell/ghc-paths-0.1:=[profile?]
	dev-haskell/ordered-containers:=[profile?]
	>=dev-haskell/syb-0.5:=[profile?]
	>=dev-lang/ghc-9.8.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.6.3.0
	test? (
		dev-haskell/diff
		>=dev-haskell/filemanip-0.3
		>=dev-haskell/hunit-1.2
		>=dev-haskell/silently-1.2
	)
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=-dev \
		--flag=-roundtrip
}
