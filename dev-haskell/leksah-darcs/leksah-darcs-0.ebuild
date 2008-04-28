# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"

inherit haskell-cabal darcs

DESCRIPTION="Haskell IDE written in Haskell"
HOMEPAGE="http://www.leksah.org"
EDARCS_REPOSITORY="http://code.haskell.org/leksah"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="!dev-haskell/leksah
		>=dev-lang/ghc-6.8.1
		>=dev-haskell/cabal-1.1.6.2
		>=dev-haskell/filepath-1.0
		>=dev-haskell/parsec-2.0
		>=dev-haskell/mtl-1.0.1
		>=dev-haskell/gtk2hs-0.9.12
		>=dev-haskell/binary-0.4
		>=dev-haskell/bytestring-0.9.0.1"
RDEPEND="${DEPEND}"

src_install() {
	cabal_src_install

	dodoc LICENSE Readme doc/Todo.txt

	if use doc; then
		dodoc doc/leksah_manual.pdf
	fi
}

