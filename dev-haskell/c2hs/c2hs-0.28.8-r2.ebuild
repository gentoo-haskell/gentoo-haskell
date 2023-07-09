# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0
#hackport: flags: -regression

CABAL_HACKAGE_REVISION=2

CABAL_FEATURES="test-suite"
inherit haskell-cabal

DESCRIPTION="C->Haskell FFI tool that gives some cross-language type safety"
HOMEPAGE="https://github.com/haskell/c2hs"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-haskell/dlist:=
	>=dev-haskell/language-c-0.7.1:= <dev-haskell/language-c-0.10:=
	>=dev-lang/ghc-8.8.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.0.0.0
	test? ( dev-haskell/hunit
		>=dev-haskell/shelly-1.9.0
		dev-haskell/test-framework
		dev-haskell/test-framework-hunit
		dev-haskell/text )
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=-regression
}
