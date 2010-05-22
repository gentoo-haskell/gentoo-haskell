# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="FFI interface to libev"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/hlibev"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

EXTRALIBS="dev-libs/libev"
HASKELLDEPS="dev-haskell/network"
RDEPEND=">=dev-lang/ghc-6.8.1
		${HASKELLDEPS}
		${EXTRALIBS}"
DEPEND="dev-haskell/cabal
		${RDEPEND}"
