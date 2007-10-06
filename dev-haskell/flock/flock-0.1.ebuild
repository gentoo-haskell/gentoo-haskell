# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal

DESCRIPTION="Wrapper for flock(2)"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/flock"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE=""	#Fixme: "OtherLicense", please fill in manually
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		dev-haskell/mtl"
