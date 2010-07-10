# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Library for manipulating FilePath's in a cross platform way."
HOMEPAGE="http://www-users.cs.york.ac.uk/~ndm/filepath/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6"

CABAL_CORE_LIB_GHC_PV="6.12.1"

src_unpack() {
	unpack "${A}"

	# it actually works with ghc-6.6.1 (which has base-2)
	sed -i 's@base >= 3 && < 5@base >= 2 \&\& < 5@g'\
	    "${S}/${PN}.cabal"
}
