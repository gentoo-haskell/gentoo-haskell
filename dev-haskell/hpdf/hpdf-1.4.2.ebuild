# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

MY_PN="HPDF"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Generation of PDF documents"
HOMEPAGE="http://www.alpheccar.org"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/binary-0.4
		>=dev-haskell/cabal-1.6
		dev-haskell/mtl
		>=dev-haskell/zlib-0.5"

S="${WORKDIR}/${MY_P}"
