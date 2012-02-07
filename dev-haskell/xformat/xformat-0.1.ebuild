# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit base haskell-cabal

DESCRIPTION="Extensible, type-safe formatting with scanf- and printf-like functions"
HOMEPAGE="http://github.com/spl/xformat/tree/master"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.1"

PATCHES=("${FILESDIR}/${PN}-0.1-ghc-7.4.patch")
