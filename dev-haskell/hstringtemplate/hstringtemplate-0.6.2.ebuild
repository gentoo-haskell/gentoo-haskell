# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="HStringTemplate"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="StringTemplate implementation in Haskell."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/HStringTemplate"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Have 6.10 to avoid problems with syb dep
DEPEND=">=dev-lang/ghc-6.10.1
		>=dev-haskell/cabal-1.6
		dev-haskell/filepath
		dev-haskell/mtl
		dev-haskell/parallel
		<dev-haskell/parsec-3
		dev-haskell/syb
		dev-haskell/syb-with-class
		dev-haskell/text
		dev-haskell/time
		dev-haskell/utf8-string"

S="${WORKDIR}/${MY_P}"
