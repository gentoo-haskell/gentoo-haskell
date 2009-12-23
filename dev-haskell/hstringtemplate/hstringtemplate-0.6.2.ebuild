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

# There are various flags available for hstringtemplate; if anyone wants them, ask.

DEPEND=">=dev-lang/ghc-6.8
		>=dev-haskell/cabal-1.6
		dev-haskell/mtl
		dev-haskell/parallel
		<dev-haskell/parsec-3
		dev-haskell/text
		dev-haskell/time
		dev-haskell/utf8-string"

S="${WORKDIR}/${MY_P}"
