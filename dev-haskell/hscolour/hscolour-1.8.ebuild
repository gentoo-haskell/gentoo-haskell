# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Colourise Haskell code"
HOMEPAGE="http://www.cs.york.ac.uk/fp/darcs/hscolour/"
SRC_URI="ftp://ftp.cs.york.ac.uk/pub/haskell/contrib/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/ghc"
RDEPEND=""

src_unpack() {
	unpack "${A}"

	# Fix for a haddock parse error, hopefully fixed after version 1.8
	sed -i -e 's|document/fragment|document\\/fragment|' \
		"${S}/Language/Haskell/HsColour/LaTeX.hs"

	# Correct version number. Doh!
	sed -i -e 's|version = "1.7"|version = "1.8"|' "${S}/HsColour.hs"
}

src_install() {
	cabal_src_install
	if use doc; then
		dohtml index.html hscolour.css
		dodoc README
	fi
}
