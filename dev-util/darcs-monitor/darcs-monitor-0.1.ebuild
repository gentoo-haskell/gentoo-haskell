# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Send email about new patches in a darcs repository"
HOMEPAGE="http://antti-juhani.kaijanaho.fi/darcs/darcs-monitor/"
SRC_URI="http://antti-juhani.kaijanaho.fi/software/dist/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND=">=dev-lang/ghc-6.2
	dev-haskell/mtl
	<=dev-haskell/haxml-1.13.2"
#does not support >haxml-1.13.2. lower bound?
