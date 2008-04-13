# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit eutils haskell-cabal

DESCRIPTION="The Haskell-Scriptable Editor"
HOMEPAGE="http://haskell.org/haskellwiki/Yi"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/alex
		>=dev-haskell/cabal-1.2
		>=dev-haskell/vty-3.0.0
		>=dev-haskell/gtk2hs-0.9.12
		>=dev-haskell/filepath-1.0
		dev-haskell/mtl
		>=dev-haskell/bytestring-0.9.0.1
		dev-haskell/fingertree
		>=dev-haskell/regex-base-0.72.0.1
		>=dev-haskell/regex-compat-0.71.0.1
		>=dev-haskell/regex-posix-0.72.0.2"

src_unpack() {
	unpack "${A}"

	cd "${S}"
	epatch "${FILESDIR}/${P}-soften-dep-ranges.patch"
}

src_compile() {
	CABAL_CONFIGURE_FLAGS="--flags=gtk --flags=vty"
	cabal_src_compile
}
