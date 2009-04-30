# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Various small helper functions for Lists, Maybes, Tuples, Functions"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/utility-ht"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6"

src_compile() {
    #Disable tests, so as not to have QC versioning issues.
    CABAL_CONFIGURE_FLAGS="--flags=-buildTest"

    cabal_src_compile
}

