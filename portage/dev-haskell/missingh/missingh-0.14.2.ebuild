# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib haddock profile"
inherit base haskell-cabal

DESCRIPTION="Collection of Haskell-related utilities"
HOMEPAGE="http://quux.org/devel/missingh"
SRC_URI="http://ftp.debian.org/debian/pool/main/m/missingh/${PN}_${PV}.tar.gz"

LICENSE="GPL-2" # mixed licence, mostly GPL
KEYWORDS="~x86"
IUSE=""
SLOT="0"

S="${WORKDIR}/missingh"

DEPEND=">=virtual/ghc-6.4.1"

src_unpack() {
	base_src_unpack

	# removes warning with later versions of cabal
	sed -i -e "s/HS-Source-Dir/HS-Source-Dirs/" "${S}/MissingH.cabal"

	# change -O2 to -O
	sed -i -e "s/GHC-Options: -O2/GHC-Options: -O/" "${S}/MissingH.cabal"

	# update keywords
	# those keywords changed names in Cabal-1.1.4, and their new names
	# are valid in Cabal-1.1.3 too.
	sed -i \
		-e "s/AllowOverlappingInstances/OverlappingInstances/" \
		-e "s/AllowUndecidableInstances/UndecidableInstances/" \
		"${S}/MissingH.cabal"
}

src_install() {
	haskell-cabal_src_install
	dodoc README COPYRIGHT
}
