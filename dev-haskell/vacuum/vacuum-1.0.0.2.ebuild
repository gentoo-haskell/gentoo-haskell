# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit base haskell-cabal

DESCRIPTION="Extract graph representations of ghc heap values."
HOMEPAGE="http://moonpatio.com/vacuum/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10.1
		>=dev-haskell/cabal-1.6"

PATCHES=("${FILESDIR}/${PN}-1.0.0-ghc-7.2.patch")
