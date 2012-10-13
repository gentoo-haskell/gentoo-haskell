# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit base haskell-cabal

DESCRIPTION="Ways to write a file cautiously, to reduce the chances of problems such as data loss due to crashes or power failures"
HOMEPAGE="http://hackage.haskell.org/package/cautious-file"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-lang/ghc-6.12.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

PATCHES=("${FILESDIR}/${PN}-1.0.1-ghc-6.12-7.6.patch")

src_compile() {
	cabal_src_compile
	ghc -o test -isrc --make Test.hs || die "test compile failed!"
}

src_test() {
	./test || die "Tests failed!"
}
