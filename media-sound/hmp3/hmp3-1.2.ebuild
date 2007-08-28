# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="An ncurses mp3 player written in Haskell"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/hmp3.html"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		|| ( media-sound/mpg321 media-sound/mpg123 )
		sys-libs/ncurses
		>=dev-haskell/binary-0.2"

src_unpack() {
	unpack "${A}"
	chmod u+x "${S}/configure"
}
