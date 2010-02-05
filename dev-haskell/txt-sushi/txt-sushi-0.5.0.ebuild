# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="The SQL link in your *NIX chain"
HOMEPAGE="http://keithsheppard.name/txt-sushi"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

HASKELLDEPS="dev-haskell/binary
		dev-haskell/parsec
		dev-haskell/regex-posix"
RDEPEND=""
DEPEND=">=dev-haskell/cabal-1.6
		>=dev-lang/ghc-6.6.1
		${RDEPEND}
		${HASKELLDEPS}"
