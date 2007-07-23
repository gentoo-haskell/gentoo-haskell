# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin lib profile"
# building haddock fails
inherit haskell-cabal

DESCRIPTION="Colourise Haskell code"
HOMEPAGE="http://www.cs.york.ac.uk/fp/darcs/hscolour/"
SRC_URI="ftp://ftp.cs.york.ac.uk/pub/haskell/contrib/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-lang/ghc"
RDEPEND=""

src_install() {
	haskell-cabal_src_install
	if use doc; then
		dohtml index.html hscolour.css
		dodoc README
	fi
}
