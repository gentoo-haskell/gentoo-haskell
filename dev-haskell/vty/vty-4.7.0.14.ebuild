# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit base haskell-cabal

DESCRIPTION="A simple terminal access library"
HOMEPAGE="https://github.com/coreyoconnor/vty"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/deepseq-1.1[profile?]
		<dev-haskell/deepseq-1.4[profile?]
		>=dev-haskell/mtl-1.1.0.2[profile?]
		<dev-haskell/mtl-2.2[profile?]
		>=dev-haskell/parallel-2.2[profile?]
		<dev-haskell/parallel-3.3[profile?]
		>=dev-haskell/parsec-2[profile?]
		<dev-haskell/parsec-4[profile?]
		=dev-haskell/terminfo-0.3*[profile?]
		=dev-haskell/utf8-string-0.3*[profile?]
		>=dev-haskell/vector-0.7[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		dev-haskell/cabal"

PATCHES=("${FILESDIR}/${PN}-4.7.0.14-ghc-7.5.patch")
