# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES=""
inherit haskell-cabal

DESCRIPTION="Darcs repository monitor (sends email)"
HOMEPAGE="http://wiki.darcs.net/RelatedSoftware/DarcsMonitor"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6
		>=dev-haskell/haxml-1.25
		dev-haskell/mtl
		>=dev-lang/ghc-6.10.1"

PATCHES=(	"${FILESDIR}/${P}-haxml-1.22.patch"
			"${FILESDIR}/${P}-ghc-7.6.patch" )

src_prepare() {
	default

	cabal_chdeps \
		'HaXml >= 1.22 && < 1.24' 'HaXml >= 1.22'
}
