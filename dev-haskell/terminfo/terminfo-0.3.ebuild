# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib"
inherit haskell-cabal

DESCRIPTION="A command-line interface for user input written in haskell"
HOMEPAGE="http://code.haskell.org/terminfo/"
SRC_URI="http://hackage.haskell.org/packages/archive/terminfo/0.3/terminfo-0.3.tar.gz"

LICENSE="BSD3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-haskell/extensible-exceptions-0.1.1.0
	sys-libs/ncurses
"
