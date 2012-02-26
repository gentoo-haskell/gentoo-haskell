# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit base haskell-cabal

DESCRIPTION="Test interactive Haskell examples"
HOMEPAGE="http://hackage.haskell.org/package/doctest"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-haskell/hunit-1.2*
		dev-haskell/haddock
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.10"

# This just makes it compile with haddock 2.10, patch is not tested and probably incorrect
PATCHES=("${FILESDIR}/${PN}-0.5.2-ghc-7.4.patch")
