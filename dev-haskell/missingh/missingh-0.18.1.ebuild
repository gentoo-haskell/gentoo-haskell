# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"
inherit base haskell-cabal

DESCRIPTION="Collection of Haskell-related utilities"
HOMEPAGE="http://software.complete.org/missingh"
SRC_URI="http://software.complete.org/missingh/static/download_area/${PV}/missingh_${PV}.tar.gz"

LICENSE="GPL-2" # mixed licence, all GPL compatible
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"

S="${WORKDIR}/missingh"

DEPEND=">=virtual/ghc-6.4.2
	dev-haskell/hunit
	dev-haskell/filepath
	dev-haskell/hslogger"

src_unpack() {
	base_src_unpack
	sed -i -e 's/FilePath/filepath/' "${S}/MissingH.cabal"
	ed ${S}/src/System/Path/Glob.hs << EOF
38
c
import System.FilePath
.
w
EOF
}

