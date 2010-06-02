# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="ConfigFile"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Configuration file reading & writing"
HOMEPAGE="http://software.complete.org/configfile"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

HASKELLDEPS=">=dev-haskell/missingh-1.0.0
		dev-haskell/mtl
		dev-haskell/parsec"
RDEPEND=">=dev-lang/ghc-6.8.1
		${HASKELLDEPS}"
DEPEND=">=dev-haskell/cabal-1.2.3
		${RDEPEND}"

S="${WORKDIR}/${MY_P}"
