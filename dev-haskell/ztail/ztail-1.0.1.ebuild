# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="bin"
inherit base haskell-cabal

DESCRIPTION="Multi-file, colored, filtered log tailer."
HOMEPAGE="http://hackage.haskell.org/package/ztail"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="inotify"

DEPEND=">=dev-lang/ghc-6.10.1
		>=dev-haskell/cabal-1.6
		dev-haskell/hinotify
		dev-haskell/regex-compat
		dev-haskell/time
		inotify? ( >=dev-haskell/hinotify-0.3.2 )
	"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/${PN}"-1.0.1-hinotify-0.3.2.patch)

src_configure() {
	cabal_src_configure $(cabal_flag inotify)
}
