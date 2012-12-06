# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Utilities to make Data.Time.* easier to use."
HOMEPAGE="http://github.com/esessoms/datetime"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		=dev-haskell/quickcheck-1.2*

	   # it should be
	   # quickcheck >= 1.2 && <2
	   # not just =1.2*

src_unpack() {
	unpack ${A}
	sed -e "s/\(QuickCheck >= 1.2\)/\\1 \\&\\& <2/" \
	  -i "${S}/${PN}.cabal"
}
