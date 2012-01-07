# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

CABAL_FEATURES="bin lib profile haddock hscolour hoogle"
inherit base haskell-cabal

DESCRIPTION="helper tool for building wxHaskell"
HOMEPAGE="http://haskell.org/haskellwiki/WxHaskell"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-haskell/parsec-2.1.0
		<dev-haskell/strict-1.0
		>=dev-haskell/time-1.0
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

PATCHES=("${FILESDIR}/${PN}-0.13.1.1-ghc-7.4.patch")
