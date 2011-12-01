# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="bin"
inherit haskell-cabal

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
		inotify? ( dev-haskell/hinotify )"
RDEPEND="${DEPEND}"


src_configure() {
	cabal_src_configure $(cabal_flag inotify)
}
