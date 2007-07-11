# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit base haskell-cabal

DESCRIPTION="hmp3 is a curses-based mp3 player frontend to mpg321 and mpg123"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/hmp3.html"
SRC_URI="http://www.cse.unsw.edu.au/~dons/hmp3/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

#if possible try testing with "~ppc" and "~sparc"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4
		|| ( media-sound/mpg321 media-sound/mpg123 )
		sys-libs/ncurses"

src_unpack() {
	base_src_unpack
	cd ${S}
	chmod u+x ./configure
}
