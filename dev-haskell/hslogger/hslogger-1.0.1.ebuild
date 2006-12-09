# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib haddock"
inherit haskell-cabal

DESCRIPTION="A logging framework for Haskell"
HOMEPAGE="http://software.complete.org/hslogger/"
SRC_URI="http://software.complete.org/hslogger/static/download_area/1.0.1/hslogger_1.0.1.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.4.1"

S="${WORKDIR}/${PN}"
