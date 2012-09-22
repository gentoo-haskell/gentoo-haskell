# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="bin lib profile haddock" # hscolour hoogle crashes on UTF8 input
inherit base haskell-cabal

DESCRIPTION="Unlambda interpreter"
HOMEPAGE="http://hackage.haskell.org/package/unlambda"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/mtl
		>=dev-lang/ghc-6.8.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

PATCHES=("${FILESDIR}/${PN}-0.1-ghc-7.6.patch")
