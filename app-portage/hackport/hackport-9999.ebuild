# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"
EDARCS_REPOSITORY="http://code.haskell.org/gentoo/hackport/"
inherit darcs haskell-cabal

DESCRIPTION="Hackage and Portage integration tool"
HOMEPAGE="http://code.haskell.org/gentoo/hackport/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10
		>=dev-haskell/cabal-1.8
		>=dev-haskell/http-4000.0.3
		dev-haskell/mtl
		dev-haskell/network
		dev-haskell/parsec
		dev-haskell/regex-compat
		dev-haskell/tar
		dev-haskell/zlib"
