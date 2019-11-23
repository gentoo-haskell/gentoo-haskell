# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Darcs repository monitor (sends email)"
HOMEPAGE="http://wiki.darcs.net/RelatedSoftware/DarcsMonitor"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6
		>=dev-haskell/haxml-1.20
		dev-haskell/mtl
		>=dev-lang/ghc-6.10.1"

src_prepare() {
	if has_version ">=dev-haskell/haxml-1.22.0"; then
		epatch "${FILESDIR}/${P}-haxml-1.22.patch"
	fi
	epatch "${FILESDIR}"/${P}-ghc-7.6.patch
	cabal_chdeps \
		'HaXml >= 1.22 && < 1.24' 'HaXml >= 1.22'
}
