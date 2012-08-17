# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="bin lib profile haddock hscolour hoogle"
inherit base haskell-cabal

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

PATCHES=("${FILESDIR}/${PN}-0.12.6-ghc-7.7.patch")

src_configure () {
	cabal_src_configure --flag=testprog
}
