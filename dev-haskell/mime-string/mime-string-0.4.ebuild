# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="MIME implementation for String's."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/mime-string"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE=""	#Fixme: "OtherLicense", please fill in manually
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/base64-string
		dev-haskell/iconv
		dev-haskell/mtl
		dev-haskell/network"
DEPEND="dev-haskell/cabal
		${RDEPEND}"
