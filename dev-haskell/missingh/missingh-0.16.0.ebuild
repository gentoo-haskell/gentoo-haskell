# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"
inherit base haskell-cabal

DESCRIPTION="Collection of Haskell-related utilities"
HOMEPAGE="http://software.complete.org/missingh"
SRC_URI="http://software.complete.org/missingh/static/download_area/0.16/missingh_${PV}.tar.gz"

LICENSE="GPL-2" # mixed licence, mostly GPL
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"

S="${WORKDIR}/missingh"

DEPEND=">=virtual/ghc-6.4.2
		dev-haskell/mtl
		dev-haskell/network
		dev-haskell/quickcheck
		dev-haskell/hunit"

src_unpack() {
	base_src_unpack

	# removes warning with later versions of cabal
	sed -i -e "s/HS-Source-Dir/HS-Source-Dirs/" "${S}/MissingH.cabal"

	# change -O2 to -O
	sed -i -e "s/GHC-Options: -O2/GHC-Options: -O/" "${S}/MissingH.cabal"

	# rexex module got it's onw package in 6.6 but before that it was in base
	# so don't dep on the regex-compat package with ghc-6.4.x
	if ! version_is_at_least "6.6" "$(ghc-version)"; then
		sed -i -e "s/regex-compat,//" "${S}/MissingH.cabal"
	fi
}

src_install() {
	cabal_src_install
	dodoc README COPYRIGHT
}
