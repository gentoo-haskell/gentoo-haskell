# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

WX_GTK_VER="2.8"

CABAL_FEATURES="lib profile haddock hscolour"
inherit base haskell-cabal wxwidgets

DESCRIPTION="wxHaskell core"
HOMEPAGE="http://haskell.org/haskellwiki/WxHaskell"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/parsec
		dev-haskell/stm
		dev-haskell/time
		>=dev-haskell/wxdirect-0.12.1.3
		>=dev-lang/ghc-6.10.1
		x11-libs/wxGTK:2.8[X]"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

PATCHES=("${FILESDIR}/${P}-db.patch")

