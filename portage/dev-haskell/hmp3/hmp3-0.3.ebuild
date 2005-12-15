# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="hmp3 is a curses-based mp3 player frontend to mpg321 and mpg123"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/hmp3.html"
SRC_URI="http://www.cse.unsw.edu.au/~dons/hmp3/hmp3-0.3.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"	#if possible try testing with "~amd64", "~ppc" and "~sparc"
IUSE=""

DEPEND=">=virtual/ghc-6.2.2
		>=dev-haskell/fps-051204"
