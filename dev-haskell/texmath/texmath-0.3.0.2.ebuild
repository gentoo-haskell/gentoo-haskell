# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Conversion of LaTeX math formulas to MathML."
HOMEPAGE="http://github.com/jgm/texmath"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cgi"

RESTRICT="test"

RDEPEND=">=dev-lang/ghc-6.10.1
		>=dev-haskell/parsec-2
		dev-haskell/xml
		cgi? ( dev-haskell/cgi
			dev-haskell/json
			dev-haskell/utf8-string )"
DEPEND=">=dev-haskell/cabal-1.2
		${RDEPEND}"

if use cgi; then
	CABAL_CONFIGURE_FLAGS="--flags=cgi"
fi
