# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Syntax highlighting"
HOMEPAGE="http://johnmacfarlane.net/highlighting-kate"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="executable"

RDEPEND=">=dev-lang/ghc-6.6.1
		<dev-haskell/parsec-4
		dev-haskell/regex-pcre-builtin
		dev-haskell/xhtml"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"


if use executable; then
    CABAL_CONFIGURE_FLAGS="--flags=executable"
fi

src_unpack() {
    unpack ${A}

    # loosen upper restriction on parsec
    sed -i -e 's/parsec < 3/parsec < 4/' \
                "${S}/${PN}.cabal"
}

