# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="bin"
inherit base haskell-cabal

DESCRIPTION="Installed package query tool for Gentoo Linux"
HOMEPAGE="http://hackage.haskell.org/package/fquery"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6
		dev-haskell/parsec
		dev-haskell/regex-compat
		>=dev-lang/ghc-6.10.1"

PATCHES=("${FILESDIR}/${PN}-0.2.1.3-ghc-7.5.patch")
