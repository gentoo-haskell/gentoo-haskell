# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0
#hackport: flags: -dev

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Interface to ‘directory’ package for users of ‘path’"
HOMEPAGE="https://github.com/mrkkrp/path-io"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/dlist-0.8:=[profile?] <dev-haskell/dlist-2:=[profile?]
	>=dev-haskell/path-0.7.1:=[profile?] <dev-haskell/path-0.10:=[profile?]
	>=dev-haskell/temporary-1.1:=[profile?] <dev-haskell/temporary-1.4:=[profile?]
	dev-haskell/unix-compat:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? ( >=dev-haskell/hspec-2 <dev-haskell/hspec-3 )
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=-dev
}
