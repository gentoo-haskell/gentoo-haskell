# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Haskell IDE written in Haskell"
HOMEPAGE="http://www.leksah.org"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/binary-0.4.4
		>=dev-haskell/bytestring-0.9.0.1
		>=dev-haskell/cabal-1.6.0.1
		>=dev-haskell/filepath-1.1.0.1
		>=dev-haskell/glib-0.10
		>=dev-haskell/gtk-0.10
		>=dev-haskell/gtksourceview2-0.10.0
		>=dev-haskell/mtl-1.1.0.2
		>=dev-haskell/parsec-2.1.0.1
		>=dev-haskell/regex-base-0.72.0.2
		>=dev-haskell/regex-compat-0.71.0.1
		>=dev-haskell/regex-posix-0.72.0.3
		>=dev-haskell/utf8-string-0.3.1.1"

RDEPEND=""

src_unpack () {
    unpack ${A}

    # Remove restriction on regex-base
    sed -i -e 's/regex-base ==/regex-base >=/' \
                "${S}/${PN}.cabal"
}
