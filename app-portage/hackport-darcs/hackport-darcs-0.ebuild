# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"
EDARCS_REPOSITORY="http://www.haskell.org/~gentoo/hackport/"
inherit darcs haskell-cabal

DESCRIPTION="Hackage and Portage integration tool"
HOMEPAGE="http://www.haskell.org/~gentoo/hackport/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/ghc
		dev-haskell/cabal
		dev-haskell/filepath
		dev-haskell/http
		dev-haskell/mtl
		dev-haskell/network
		dev-haskell/tar
		dev-haskell/zlib
		dev-haskell/regex-compat"
