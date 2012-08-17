# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="bin lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="Parsing and extracting information from (possibly malformed) HTML/XML documents"
HOMEPAGE="http://community.haskell.org/~ndm/tagsoup/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/text[profile?]
		=dev-haskell/deepseq-1.3*[profile?]
		>=dev-haskell/quickcheck-2.4[profile?]
		<dev-haskell/quickcheck-2.6[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	sed -e 's@deepseq == 1.1.\*@deepseq@' \
		-e 's@QuickCheck == 2.4.\*@QuickCheck >= 2.4 \&\& < 2.6@' \
		-i "${S}/${PN}.cabal"
}
src_configure () {
	cabal_src_configure --flag=testprog
}
