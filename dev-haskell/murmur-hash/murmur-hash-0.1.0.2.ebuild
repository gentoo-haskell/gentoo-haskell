# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="MurmurHash2 implementation for Haskell."
HOMEPAGE="http://github.com/nominolo/murmur-hash"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	sed -e 's@base          >= 3.0 && < 4.4@base          >= 3.0 \&\& < 4.5@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen base dependency"
}
