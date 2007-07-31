# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile lib" # haddock docs do not build
inherit haskell-cabal

DESCRIPTION="Useful standard collections types and related functions."
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		>=dev-haskell/quickcheck-1.0.1"

src_unpack() {
	unpack "${A}"

	# Remove duplicate instance
	sed -i -e "/instance Arbitrary/,+7 d" "${S}/Data/Collections/Properties.hs"
}
