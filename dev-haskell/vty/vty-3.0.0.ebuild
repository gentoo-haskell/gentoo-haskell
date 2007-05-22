# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib"
inherit haskell-cabal eutils

DESCRIPTION="Simplistic terminal library for Haskell"
HOMEPAGE="http://members.cox.net/stefanor/vty/dist/doc/html/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.6"

