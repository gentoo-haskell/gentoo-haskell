# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="A program and library to derive instances for data types"
HOMEPAGE="http://community.haskell.org/~ndm/derive/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/haskell-src-exts-1.9.6
		=dev-haskell/transformers-0.2*
		=dev-haskell/uniplate-1.6
		>=dev-lang/ghc-6.8.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	sed -e 's@haskell-src-exts == 1.9.\*@haskell-src-exts >= 1.9.0 \&\& < 1.11.0@g' \
		-i "${S}/${PN}.cabal"
}
