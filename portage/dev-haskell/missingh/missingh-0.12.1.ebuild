# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="haddock profile"
inherit haskell-cabal

DESCRIPTION="Collection of Haskell-related utilities"
HOMEPAGE="http://quux.org/devel/missingh"
SRC_URI="http://ftp.debian.org/debian/pool/main/m/missingh/${PN}_${PV}.tar.gz"

LICENSE="GPL-2" # mixed licence, mostly GPL
KEYWORDS="~x86"
IUSE=""
SLOT="0"

S="${WORKDIR}/missingh"

# only requires cabal-0.5, so ghc-6.4 without dev-haskell/cabal would be ok too
DEPEND=">=virtual/ghc-6.2
	>=dev-haskell/cabal-0.5"
