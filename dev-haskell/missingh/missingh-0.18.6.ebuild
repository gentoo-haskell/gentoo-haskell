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

DEPEND=">=dev-lang/ghc-6.4.2
	>=dev-haskell/hunit-1.1
	>=dev-haskell/filepath-1.0
	>=dev-haskell/hslogger-1.0.1
	>=dev-haskell/mtl-1.0
	>=dev-haskell/hunit-1.1
	>=dev-haskell/network-1.0
	>=dev-haskell/quickcheck-1.0"
